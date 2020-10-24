package fastcom_svc

import (
	"database/sql"
	"github.com/bmsandoval/gofastcom/pkg/models"
	_ "github.com/mattn/go-sqlite3"
)

var listSql=`
SELECT  hr_created_at, minimum, maximum, median, average
FROM measurements`

func List(conn *sql.DB) ([]models.Measurement, error) {
	rows, _ := conn.Query(listSql)

	var measurements []models.Measurement
	for rows.Next() {
		var measurement models.Measurement
		if err := rows.Scan( &measurement.CreatedAt, &measurement.Minimum,
			&measurement.Maximum, &measurement.Median, &measurement.Average); err != nil {

			return nil, err
		}

		measurements = append(measurements, measurement)
	}

	return measurements, nil
}