package models

import (
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
    "log"
)

var DB *sql.DB

type StandardResult struct {
    Success   	bool   `json:"success"`
    Message 	string `json:"message"`
}

func InitDB(dataSourceName string) {
    var err error
    DB, err = sql.Open("mysql", dataSourceName)
    if err != nil {
        log.Panic(err)
    }
}

func ErrorCheck(err error) {
    if err != nil {
        panic(err.Error())
    }
}