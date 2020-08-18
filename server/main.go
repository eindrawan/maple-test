package main

import (
	"fmt"
	"log"
    "net/http"
	_ "github.com/go-sql-driver/mysql"
    "github.com/gorilla/mux"
	

	"./models"
	"./controllers/admin"
	"./controllers/product"
	"./controllers/cart"
)

func handleRequests() {
	router := mux.NewRouter().StrictSlash(true)
	models.InitDB("root:1234@tcp(db:3306)/maple")
	defer models.DB.Close()
	
    router.HandleFunc("/login", admin.Login).Methods(http.MethodPost, http.MethodOptions)
	router.HandleFunc("/products", product.List).Methods(http.MethodGet)	
	router.HandleFunc("/cart/add", cart.Add).Methods(http.MethodPost, http.MethodOptions)
	router.HandleFunc("/cart/remove", cart.Remove).Methods(http.MethodPost, http.MethodOptions)
	router.HandleFunc("/cart", cart.List).Methods(http.MethodPost, http.MethodOptions)
	router.HandleFunc("/cart/checkout", cart.Checkout).Methods(http.MethodPost, http.MethodOptions)
	
    log.Fatal(http.ListenAndServe(":8001", router))
}

func main() {
	fmt.Println("Maple Test Server Started")
	handleRequests()
}