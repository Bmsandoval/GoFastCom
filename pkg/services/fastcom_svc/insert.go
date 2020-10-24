package fastcom_svc

import (
	"database/sql"
	"github.com/bmsandoval/gofastcom/pkg/models"
	_ "github.com/mattn/go-sqlite3"
)

var insertSql = `
INSERT INTO measurements (
	created_at, minimum, maximum, median, average
)
VALUES (
	(strftime('%s','now')), ?, ?, ?, ?
)`

func Insert(conn *sql.DB, measurement *models.Measurement) error {
	statement, _ := conn.Prepare(insertSql)
	if _, err := statement.Exec(measurement.Minimum, measurement.Maximum,
		measurement.Median, measurement.Average); err != nil {
		return err
	}

	return nil
}