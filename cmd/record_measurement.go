package cmd

import (
	"fmt"
	"github.com/bmsandoval/gofastcom/pkg/services/fastcom_svc"
	"github.com/spf13/cobra"
	"os"
)

var RecordMeasurementCmd = &cobra.Command{
	Use:     "record",
	Aliases: []string{"r"},
	Short:   "take new measurement and record it",
	Run:     RecordMeasurement,
}

func RecordMeasurement(_ *cobra.Command, _ []string) {
	measurement, err := fastcom_svc.Measure()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	conn, err := fastcom_svc.DbConnect(DbLocation)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	fmt.Printf(" Low:%d\n High:%d\n Avg:%d\n Median:%d\n",
		measurement.Minimum,
		measurement.Maximum,
		measurement.Average,
		measurement.Median,
	)

	if err := fastcom_svc.Insert(conn, measurement); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	fmt.Println("Measurement taken and stored")
}

func init() {
	rootCmd.AddCommand(RecordMeasurementCmd)
}
