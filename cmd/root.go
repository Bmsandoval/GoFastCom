/*
Copyright © 2019 NAME HERE <EMAIL ADDRESS>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
package cmd

import (
  "fmt"
  "github.com/bmsandoval/gofastcom/services/fastcom_svc"
  "github.com/spf13/cobra"
  "os"
)


// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
  Use:   "gofastcom",
  Short: "A brief description of your application",
  Long: `A longer description that spans multiple lines and likely contains
examples and usage of using your application. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
  //Uncomment the following line if your bare application
  //has an action associated with it:
  	Run: Measure,
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
  if err := rootCmd.Execute(); err != nil {
    fmt.Println(err)
    os.Exit(1)
  }
}

func Measure(cmd *cobra.Command, args []string) {
  measurement, err := fastcom_svc.Measure()
  if err != nil {
    fmt.Println(err)
    os.Exit(1)
  }



  fmt.Printf("Low:%.0f,High:%.0f,Avg:%.0f,Median:%.0f\n",
    measurement.Minimum,
    measurement.Maximum,
    measurement.Average,
    measurement.Median,
  )
}
