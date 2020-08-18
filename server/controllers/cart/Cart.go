package cart

import (
    // "fmt"
    "encoding/json"
    "net/http"
    "io/ioutil"
    
    "../../models"
)

type ReturnValue struct{
    Success     bool
    Message     string
}

func Add(w http.ResponseWriter, r *http.Request){
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.Header().Set("Access-Control-Allow-Headers","Content-Type,access-control-allow-origin, access-control-allow-headers")
    
    type params struct {
        UserId      int `json:"user_id"`
        ProductId   int `json:"product_id"`
    }
    reqBody, _ := ioutil.ReadAll(r.Body)
    var p = params{}
    json.Unmarshal(reqBody, &p)
    
    models.AddCart(p.UserId, p.ProductId)
    ret := models.ListCart(p.UserId)
    json.NewEncoder(w).Encode(ret)  
}

func Remove(w http.ResponseWriter, r *http.Request){
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.Header().Set("Access-Control-Allow-Headers","Content-Type,access-control-allow-origin, access-control-allow-headers")
    
    type params struct {
        UserId      int `json:"user_id"`
        ProductId   int `json:"product_id"`
    }
    reqBody, _ := ioutil.ReadAll(r.Body)
    var p = params{}
    json.Unmarshal(reqBody, &p)
    
    models.RemoveCart(p.UserId, p.ProductId)
    ret := models.ListCart(p.UserId)
    json.NewEncoder(w).Encode(ret)  
}

func List(w http.ResponseWriter, r *http.Request){
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.Header().Set("Access-Control-Allow-Headers","Content-Type,access-control-allow-origin, access-control-allow-headers")
    
    type params struct {
        UserId      int `json:"user_id"`
    }
    reqBody, _ := ioutil.ReadAll(r.Body)
    var p = params{}
    json.Unmarshal(reqBody, &p)
    
    ret := models.ListCart(p.UserId)
    json.NewEncoder(w).Encode(ret)  
}

func Checkout(w http.ResponseWriter, r *http.Request){
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.Header().Set("Access-Control-Allow-Headers","Content-Type,access-control-allow-origin, access-control-allow-headers")
    
    type params struct {
        UserId      int `json:"user_id"`
    }
    reqBody, _ := ioutil.ReadAll(r.Body)
    var p = params{}
    json.Unmarshal(reqBody, &p)
    
    ret := models.Checkout(p.UserId);
    json.NewEncoder(w).Encode(ret)  
}