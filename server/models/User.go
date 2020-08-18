package models

import "fmt"

type User struct {
    Id   		int    `json:"id"`
    Username 	string `json:"username"`
}

type UserResult struct {
    Success   	bool   `json:"success"`
    Data        User   `json:"data"`        
    Message 	string `json:"message"`
}

func UserLogin(username string, password string)(UserResult){
    var user User
	// Execute the query
    err := DB.QueryRow("SELECT id, username FROM Users WHERE username = ? AND password = ?", username, password).Scan(&user.Id, &user.Username)
   
    if err != nil {
        fmt.Println(err)
		return UserResult{Success:false, Message:"Login Failed"}
	} else {
        return UserResult{Success:true, Data:user, Message:"Login Successfull"}
    }
}