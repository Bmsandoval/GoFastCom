package cmd

import (
	"fmt"
	"github.com/bmsandoval/gofastcom/pkg/services/fastcom_svc"
	"github.com/spf13/cobra"
	"os"
)

var ListMeasurementsCmd = &cobra.Command{
	Use:     "list",
	Aliases: []string{"l"},
	Short:   "list all recorded measurements",
	Run:     ListMeasurements,
}

func ListMeasurements(_ *cobra.Command, _ []string) {
	conn, err := fastcom_svc.DbConnect(DbLocation)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	measurements, err := fastcom_svc.List(conn)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	for _, measurement := range measurements {
		fmt.Printf("Taken:%s\n Low:%d\n High:%d\n Avg:%d\n Median:%d\n----------\n",
			measurement.CreatedAt,
			measurement.Minimum,
			measurement.Maximum,
			measurement.Average,
			measurement.Median,
		)
	}
}

func init() {
	rootCmd.AddCommand(ListMeasurementsCmd)
}
