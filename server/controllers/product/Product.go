package product

import (
    // "fmt"
    "encoding/json"
    "net/http"
    
    "../../models"
)

func List(w http.ResponseWriter, r *http.Request){
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.Header().Set("Access-Control-Allow-Headers","Content-Type,access-control-allow-origin, access-control-allow-headers")
    
    
    ret := models.ListProducts()
    json.NewEncoder(w).Encode(ret)
    
}
