package fastcom_svc

import (
	"errors"
	"gopkg.in/ddo/go-fast.v0"
	"sort"
)

type Measurement struct {
	Results []float64
	Minimum float64
	Maximum float64
	Median float64
	Average float64
}

// First channel response is how many responses you will get (how many tests it will run)
// All following channel responses are the result of each test
func Measure() (*Measurement, error) {
	fastCom := fast.New()

	// init
	err := fastCom.Init()
	if err != nil {
		return nil, err
	}

	// get urls
	urls, err := fastCom.GetUrls()
	if err != nil {
		return nil, err
	}

	var speeds []float64
	var sum float64

	// measure
	KbpsChan := make(chan float64)
	go func() {
		for Kbps := range KbpsChan {
			speeds = append(speeds, Kbps/1000)
			sum += Kbps/1000
		}
	}()

	err = fastCom.Measure(urls, KbpsChan)
	if err != nil {
		return nil, err
	}


	if speeds == nil {
		return nil, errors.New("fast.com returned no results")
	}

	sort.Float64s(speeds)

	lowest := speeds[0]
	highest := speeds[len(speeds)-1]
	var median float64
	if len(speeds) == 1 {
		median = speeds[0]
	} else if 0<len(speeds)%2 { // if this is >0, it's odd
		median = speeds[(len(speeds)/2)]
	} else { // else even
		middleIsh := len(speeds)/2
		medianOne := speeds[middleIsh - 1]
		medianTwo := speeds[middleIsh]
		median = (medianOne+medianTwo)/2
	}
	average := sum/float64(len(speeds))

	return &Measurement{
		Results: speeds,
		Minimum: lowest,
		Maximum: highest,
		Median:  median,
		Average: average,
	}, nil
}
