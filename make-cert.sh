#!/bin/bash

DATE=`date +%Y-%m-%d`

echo "Enter client identifier: "
read client

if [ ! -f $client.key ]; then
	openssl genrsa -out $client/$client.key 4096
fi

openssl req -new -key $client/$client.key -out $client/$DATE.csr
openssl x509 -CAcreateserial -CAserial ca/ca.seq -req -days 90 -in $client/$DATE.csr -CA ca/ca.crt -CAkey ca/ca.key -out $client/$DATE.crt
openssl pkcs12 -export -clcerts -in $client/$DATE.crt -inkey $client/$client.key -out $client/$DATE.p12
openssl verify -CAfile ca/ca.crt $client/$DATE.crt
