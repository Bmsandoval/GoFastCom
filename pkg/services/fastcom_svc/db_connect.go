package fastcom_svc

import (
	"database/sql"
)

func DbConnect(filename string) (*sql.DB, error) {
	conn, err := sql.Open("sqlite3", filename)
	if err != nil {
		return nil, err
	}

	return conn, nil
}