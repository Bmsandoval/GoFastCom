package cmd

import (
	"fmt"
	"github.com/bmsandoval/gofastcom/pkg/services/fastcom_svc"
	"github.com/spf13/cobra"
	"os"
)

var MeasurementCmd = &cobra.Command{
	Use:     "measure",
	Aliases: []string{"m"},
	Short:   "take new measurement and display it",
	Run:     Measure,
}

func Measure(cmd *cobra.Command, args []string) {
	measurement, err := fastcom_svc.Measure()
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
}

func init() {
	rootCmd.AddCommand(MeasurementCmd)
}
