package admin

import (
    // "fmt"
    "encoding/json"
    "net/http"
    "io/ioutil"
    
    "../../models"
)

func Login(w http.ResponseWriter, r *http.Request){
    w.Header().Set("Access-Control-Allow-Origin", "*")
    w.Header().Set("Access-Control-Allow-Headers","Content-Type,access-control-allow-origin, access-control-allow-headers")
    
    type params struct {
        Username string `json:"username"`
        Password string `json:"password"`
    }
    reqBody, _ := ioutil.ReadAll(r.Body)
    var p = params{}
    json.Unmarshal(reqBody, &p)

    ret := models.UserLogin(p.Username, p.Password)
    json.NewEncoder(w).Encode(ret)
    
}
