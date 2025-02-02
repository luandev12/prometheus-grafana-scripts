package main

import (
	"flag"
	"fmt"
	"math/rand"
	"os"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/push"
)

func main() {
	var pushgatewayEndpoint = flag.String("endpoint", "http://luandev:9091", "Pushgateway endpoint. default: http://localhost:9091")
	var jobName = flag.String("job", "sample_job", "Job name. default: sample_job")
	flag.Parse()
	if flag.NFlag() > 2 {
		fmt.Println("flags : --endpoint, --job")
		os.Exit(1)
	}
	fmt.Println(*pushgatewayEndpoint)
	fmt.Println(*jobName)

	randomValue := prometheus.NewGauge(prometheus.GaugeOpts{
		Name: "random_value",
		Help: "Float64 random value generated by golang.",
	})

	rand.Seed(time.Now().UnixNano())
	randomValue.Set(rand.Float64())

	if err := push.New(*pushgatewayEndpoint, *jobName).
		Collector(randomValue).
		Grouping("sample_label", "sample_label_value").
		Push(); err != nil {
		fmt.Println("Could not push metrics to Pushgateway:", err)
		os.Exit(1)
	}
	fmt.Println("Metrics pushed successfully.")
}
