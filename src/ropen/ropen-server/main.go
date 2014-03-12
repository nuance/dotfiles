package main

import (
	"encoding/gob"
	"flag"
	"io/ioutil"
	"net"
	"os"
	"os/exec"
	"path/filepath"
)

var location = flag.String("location", "localhost:9998", "location to listen on")

type Data struct {
	Name     string
	Contents []byte
}

func main() {
	flag.Parse()

	l, err := net.Listen("tcp", *location)
	if err != nil {
		panic(err)
	}

	dir := os.TempDir()

	for {
		conn, err := l.Accept()
		if err != nil {
			panic(err)
		}

		go handle(conn, dir)
	}
}

func handle(conn net.Conn, dir string) {
	defer conn.Close()

	d := new(Data)
	if err := gob.NewDecoder(conn).Decode(d); err != nil {
		panic(err)
	}

	file := filepath.Join(dir, d.Name)
	if err := ioutil.WriteFile(file, d.Contents, 0777); err != nil {
		panic(err)
	}

	if err := exec.Command("open", file).Run(); err != nil {
		panic(err)
	}
}
