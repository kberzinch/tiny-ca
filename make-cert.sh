#!/bin/bash

if [ ! -f ca/ca.key ]; then
	echo "No CA key found. Run make-ca.sh first."
	exit
fi

if [ ! -f ca/ca.crt ]; then
	echo "No CA certificate found. Run make-ca.sh first."
	exit
fi

DATE=`date +%Y-%m-%d`

echo "Enter client identifier: "
read client

mkdir $client

if [ ! -f $client.key ]; then
	echo "No key found for client - generating now..."
	openssl genrsa -out $client/$client.key 4096
fi

echo "Cleaning up old files..."
rm *.p12

echo "Generating CSR..."
openssl req -new -key $client/$client.key -out $client/$DATE.csr

echo "Signing CSR..."
openssl x509 -CAcreateserial -CAserial ca/ca.seq -req -days 90 -in $client/$DATE.csr -CA ca/ca.crt -CAkey ca/ca.key -out $client/$DATE.crt

echo "Exporting to P12 file..."
openssl pkcs12 -export -clcerts -in $client/$DATE.crt -inkey $client/$client.key -out $client/$DATE.p12

echo "Verifying certificate..."
openssl verify -CAfile ca/ca.crt $client/$DATE.crt

rm $client/$DATE.csr
rm $client/$DATE.crt

chmod 400 $client/$client.key
chmod 444 $client/$DATE.p12
