#!/bin/bash

if [ ! -f ca/ca.key ]; then
	openssl genrsa -out ca/ca.key 4096
fi

openssl req -x509 -new -nodes -key ca/ca.key -sha256 -days 365 -out ca/ca.crt
