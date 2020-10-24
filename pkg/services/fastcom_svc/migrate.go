package fastcom_svc

import (
	"database/sql"
	_ "github.com/mattn/go-sqlite3"
)

var migrationSql = `
CREATE TABLE IF NOT EXISTS measurements (
    id INTEGER PRIMARY KEY,
    created_at INTEGER,
    hr_created_at TEXT AS (datetime(created_at,'unixepoch')),
    minimum INTEGER,
    maximum INTEGER,
    median INTEGER,
    average INTEGER
);`

func Migrate(conn *sql.DB) error {
	statement, err := conn.Prepare(migrationSql)
	if err != nil {
		return err
	}

	if _, err := statement.Exec(); err != nil {
		return err
	}

	return nil
}
