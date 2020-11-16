#!/bin/bash

GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOROOT/bin
go run . record
