package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"
	"strings"

	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

const version = "0.1"

type myInfo struct {
	Hostname string
	IPs      []string
	Headers  map[string]string
}

func handlerWhoami(w http.ResponseWriter, r *http.Request) {
	log.Printf("whoami: remote address %v\n", r.RemoteAddr)
	hostname, err := os.Hostname()
	if err != nil {
		http.Error(w, "Error hostname!", 500)
		return
	}
	ifaces, err := net.Interfaces()
	if err != nil {
		http.Error(w, "Error network interfaces!", 500)
		return
	}
	response := &myInfo{
		Hostname: hostname,
		Headers:  map[string]string{},
	}
	for _, iface := range ifaces {
		addrs, err := iface.Addrs()
		if err != nil {
			http.Error(w, "Error interface address!", 500)
			return
		}
		for _, addr := range addrs {
			var ip net.IP
			switch v := addr.(type) {
			case *net.IPNet:
				ip = v.IP
			case *net.IPAddr:
				ip = v.IP
			}
			response.IPs = append(response.IPs, ip.String())
		}
	}
	for name, headers := range r.Header {
		response.Headers[name] = strings.Join(headers, ",")
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func handlerHealth(w http.ResponseWriter, r *http.Request) {
	log.Println("health check")
	response := struct {
		Health string
	}{"ok"}
	json.NewEncoder(w).Encode(response)
}

func main() {
	pflag.String("host", "", "whoami host name")
	pflag.Int("port", 8000, "whoami host port")
	pflag.Parse()
	viper.SetEnvPrefix("WHOAMI")
	viper.BindEnv("host")
	viper.BindEnv("port")
	viper.BindPFlags(pflag.CommandLine)
	host := viper.GetString("host")
	port := viper.GetInt("port")

	log.Printf("%s %s\n", os.Args[0], version)
	http.HandleFunc("/whoami", handlerWhoami)
	http.HandleFunc("/health", handlerHealth)
	addr := fmt.Sprintf("%v:%v", host, port)
	log.Printf("whoami listening http at %s\n", addr)
	err := http.ListenAndServe(addr, nil)
	if err != nil {
		log.Printf("ListenAndServe: %v", err)
	}
}
