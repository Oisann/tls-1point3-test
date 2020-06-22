// generated 2020-06-22, Mozilla Guideline v5.4, Golang 1.13.6, modern configuration
// https://ssl-config.mozilla.org/#server=golang&version=1.13.6&config=modern&guideline=5.4
package main

import (
	"crypto/tls"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/", func(w http.ResponseWriter, req *http.Request) {
		w.Header().Add("Strict-Transport-Security", "max-age=63072000")
		w.Write([]byte("This server is running the Mozilla modern configuration.\n"))
	})

	mux.HandleFunc("/content", func(w http.ResponseWriter, r *http.Request) {
		contents, err := ioutil.ReadFile("./files/content")
		if err != nil {
			panic(err) // or do something useful
		}
		w.WriteHeader(200)
		w.Header().Add("Strict-Transport-Security", "max-age=63072000")
		w.Write(contents)
	})

	cfg := &tls.Config{
		MinVersion:               tls.VersionTLS13,
		PreferServerCipherSuites: false,
		CipherSuites:             []uint16{},
	}
	srv := &http.Server{
		Addr:         ":443",
		Handler:      mux,
		TLSConfig:    cfg,
		TLSNextProto: make(map[string]func(*http.Server, *tls.Conn, http.Handler), 0),
	}

	// due to Go limitations, it is highly recommended that you use an ECDSA
	// certificate, or you may experience compatibility issues
	log.Fatal(srv.ListenAndServeTLS(
		"./certs/cert.pem",
		"./certs/ec_key.pem",
	))
}
