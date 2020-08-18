package models

import (
	"fmt"
)

type Product struct {
	Id			int 	`json:"id"`
	ProductName	string	`json:"product_name"`
	CategoryId	int		`json:"category_id"`
	ImgURL		string	`json:"img_url"`
	Price		float64	`json:"price"`
}

type ProductResult struct {
	Success		bool 		`json:"success"`
	Data		[]*Product	`json:"data"`
    Message 	string 		`json:"message"`	
}

func ListProducts()(ProductResult){
	rows, err := DB.Query("SELECT id, product_name, category_id, img_url, price FROM Products")
    if err != nil {
		fmt.Println(err)
        return ProductResult{Success:false, Message:"Error while querying products"}
    }
	defer rows.Close()
	
	products := make([]*Product, 0)
    for rows.Next() {
        p := new(Product)
        err := rows.Scan(&p.Id, &p.ProductName, &p.CategoryId, &p.ImgURL, &p.Price)
        if err != nil {
			fmt.Println(err)
            return ProductResult{Success:false, Message:"Error while retrieving products"}
        }
        products = append(products, p)
    }
    if err = rows.Err(); err != nil {
        return ProductResult{Success:false, Message:"Error while retrieving products"}
    }
    return ProductResult{Success:true, Data:products, Message:""}
}