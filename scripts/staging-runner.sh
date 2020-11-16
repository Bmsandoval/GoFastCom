#!/bin/bash

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=/go
export PATH=$PATH:$GOROOT/bin:$GOPATH
go run . record
