package models

import (
    "log"
    "context"
)

type CartItem struct {
    ProductId   int     `json:"product_id"`
    ProductName string  `json:"product_name"`
    ImgUrl      string  `json:"img_url"`
    Qty 	    string  `json:"qty"`
    Price 	    float64  `json:"price"`
    PriceTotal 	float64  `json:"price_total"`
}

type CartItemResult struct {
    Success   	bool   `json:"success"`
    Data        []*CartItem   `json:"data"`        
    Message 	string `json:"message"`
}

func AddCart(user_id int, product_id int){
    // prepare  
    stmt, _ := DB.Prepare(`INSERT INTO UserCart (user_id, product_id, qty, price, added_date)
                SELECT ?, id, 1, price, NOW() FROM Products WHERE id = ?
                ON DUPLICATE KEY UPDATE 
                    Qty = Qty+1`)
    stmt.Exec(user_id, product_id)
}

func RemoveCart(user_id int, product_id int){
    // prepare  
    stmt, _ := DB.Prepare(`UPDATE UserCart SET qty = qty - 1
                WHERE user_id = ? AND product_id = ?`)
    stmt.Exec(user_id, product_id)

    stmt, _ = DB.Prepare(`DELETE FROM UserCart
                WHERE user_id = ? AND product_id = ? AND qty = 0`)
    stmt.Exec(user_id, product_id)
}

func ListCart(user_id int)(CartItemResult){
    rows, err := DB.Query(`SELECT uc.product_id, p.product_name, p.img_url, uc.qty, p.price, uc.qty*p.price price_total FROM UserCart uc
                    JOIN Products p
                    ON uc.product_id = p.id
                WHERE uc.user_id = ?`, user_id)
    if err != nil {
		log.Fatal(err)
        return CartItemResult{Success:false, Message:"Error while querying Cart"}
    }
	defer rows.Close()
	
	products := make([]*CartItem, 0)
    for rows.Next() {
        p := new(CartItem)
        err := rows.Scan(&p.ProductId, &p.ProductName, &p.ImgUrl, &p.Qty, &p.Price, &p.PriceTotal)
        if err != nil {
            log.Fatal(err)
            return CartItemResult{Success:false, Message:"Error while retrieving Cart"}
        }
        products = append(products, p)
    }
    if err = rows.Err(); err != nil {
        return CartItemResult{Success:false, Message:"Error while retrieving Cart"}
    }
    return CartItemResult{Success:true, Data:products, Message:""}
}

func Checkout(user_id int)(StandardResult){
    // prepare  
    ctx := context.Background()
    tx, err := DB.BeginTx(ctx, nil)

    _, err = tx.ExecContext(ctx, `UPDATE Products p
                JOIN UserCart c
                    ON p.id = c.product_id 
                    AND c.user_id = ?
                SET p.QtyOnHand = p.QtyOnHand - c.qty
                `, user_id)
    if(err != nil) { log.Println(err) }
    
    var product_name string
    err = tx.QueryRowContext(ctx, `SELECT p.product_name FROM Products p
                JOIN UserCart c
                    ON p.id = c.product_id 
                    AND c.user_id = ?
                WHERE p.QtyOnHand < 0
                `, user_id).Scan(&product_name)

	if err == nil || product_name != "" {
		tx.Rollback()
		return StandardResult{Success:false, Message: product_name+" is out of stock"}
    }
    
    _, err = tx.ExecContext(ctx, `INSERT INTO CheckOut (user_id, price_total, delivery_charge, grand_total, paid_amt)
                SELECT user_id, SUM(uc.price * uc.qty), 0, SUM(uc.price * uc.qty), SUM(uc.price * uc.qty) FROM UserCart uc 
                WHERE user_id = ?
                GROUP BY user_id
                `, user_id)
    if(err != nil) { log.Println(err) }

    _, err = tx.ExecContext(ctx, `DELETE FROM UserCart WHERE user_id = ?`, user_id)
    if(err != nil) { log.Println(err) }

    err = tx.Commit()
	if err != nil {
		log.Fatal(err)
		return StandardResult{Success:false, Message:"Error while checking your the cart"}
    }
    
    return StandardResult{Success:true, Message:"Checkout successfull"}
}