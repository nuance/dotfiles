package main

import (
	"encoding/gob"
	"flag"
	"io/ioutil"
	"net"
	"path/filepath"
)

var location = flag.String("location", "localhost:9998", "location to use")

type Data struct {
	Name     string
	Contents []byte
}

func main() {
	flag.Parse()

	path := flag.Args()[0]
	filename := filepath.Base(path)
	data, err := ioutil.ReadFile(path)
	if err != nil {
		panic(err)
	}

	conn, err := net.Dial("tcp", *location)
	if err != nil {
		panic(err)
	}
	defer conn.Close()

	if err := gob.NewEncoder(conn).Encode(Data{Name: filename, Contents: data}); err != nil {
		panic(err)
	}
}
