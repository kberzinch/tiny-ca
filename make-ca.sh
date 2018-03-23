#!/bin/bash

mkdir ca

if [ ! -f ca/ca.key ]; then
	echo "No CA key found - generating now..."
	openssl genrsa -aes256 -out ca/ca.key 4096
fi

echo "Generating CA certificate now..."
openssl req -x509 -new -nodes -key ca/ca.key -sha256 -days 365 -out ca/ca.crt

# Ensure safe file permissions are set
chmod 400 ca/ca.key
chmod 444 ca/ca.crt
