package main

import (
	"crypto/tls"
	"crypto/x509"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"

	"github.com/spf13/pflag"
	"github.com/spf13/viper"
)

//
// resource:
// https://eli.thegreenplace.net/2021/go-https-servers-with-tls/
//

const version = "0.1"

func newProxy(target string) (*url.URL, *httputil.ReverseProxy, error) {
	targetUrl, err := url.Parse(target)
	if err != nil {
		return nil, nil, fmt.Errorf("target URL: %w", err)
	}
	proxy := httputil.NewSingleHostReverseProxy(targetUrl)
	return targetUrl, proxy, nil
}

func handler(targetUrl *url.URL, proxy *httputil.ReverseProxy) func(http.ResponseWriter, *http.Request) {
	return func(w http.ResponseWriter, r *http.Request) {
		r.URL.Host = targetUrl.Host
		r.URL.Scheme = targetUrl.Scheme
		r.Host = targetUrl.Host
		proxy.ServeHTTP(w, r)
	}
}

func main() {
	// parse flags
	// for https connection, need cert and key flags
	// for https and mtls connection, need ca, cert and key flags
	pflag.String("host", "", "whoami host name")
	pflag.Int("port", 8000, "whoami host port")
	pflag.String("target", "http://whoami:8000/", "whoami target host address")
	pflag.String("caPath", "", "ca file path; along with cert and key flag will require https and mtls connection")
	pflag.String("certPath", "", "cert file path; along with key flag will require https connection")
	pflag.String("keyPath", "", "key file path; along with cert flag will require https connection")
	pflag.Parse()
	viper.SetEnvPrefix("WHOAMI")
	viper.BindEnv("host")
	viper.BindEnv("port")
	viper.BindEnv("target")
	viper.BindEnv("caPath")
	viper.BindEnv("certPath")
	viper.BindEnv("keyPath")
	viper.BindPFlags(pflag.CommandLine)
	host := viper.GetString("host")
	port := viper.GetInt("port")
	target := viper.GetString("target")
	caPath := viper.GetString("caPath")
	certPath := viper.GetString("certPath")
	keyPath := viper.GetString("keyPath")

	targetUrl, proxy, err := newProxy(target)
	if err != nil {
		log.Printf("Error target URL: %v", target)
	}

	// get server listen address
	addr := fmt.Sprintf("%s:%d", host, port)
	log.Printf("%s %s\n", os.Args[0], version)
	// get server mux (or router)
	mux := http.NewServeMux()
	// register handler
	mux.HandleFunc("/", handler(targetUrl, proxy))
	// start http/https server
	if certPath != "" && keyPath != "" {
		log.Printf("gateway listening https at %s\n", addr)
		pool, err := getCertPool(caPath)
		if err != nil {
			log.Fatalf("Get cert pool: %v", err)
		}
		var clientAuth tls.ClientAuthType
		if caPath != "" {
			clientAuth = tls.RequireAndVerifyClientCert
		} else {
			clientAuth = tls.NoClientCert
		}
		server := &http.Server{
			Addr:    addr,
			Handler: mux,
			TLSConfig: &tls.Config{
				ClientCAs:  pool,
				ClientAuth: clientAuth,
			},
		}
		err = server.ListenAndServeTLS(certPath, keyPath)
		log.Printf("ListenAndServe: %v", err)
	} else {
		log.Printf("gateway listening http at %s\n", addr)
		err = http.ListenAndServe(addr, mux)
		log.Printf("ListenAndServe: %v", err)
	}
}

func getCertPool(caFile string) (*x509.CertPool, error) {
	pool, err := x509.SystemCertPool()
	if err != nil {
		log.Printf("No system cert pool")
		pool = x509.NewCertPool()
	}
	if caFile != "" {
		caBytes, err := ioutil.ReadFile(caFile)
		if err != nil {
			return nil, fmt.Errorf("read file: %w", err)
		}
		ok := pool.AppendCertsFromPEM(caBytes)
		if !ok {
			return nil, fmt.Errorf("append cert: %w", err)
		}
	}
	return pool, nil
}
