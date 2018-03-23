# Tiny CA

This is a collection of small bash scripts to assist in generating client certificates to authenticate users to services.

Note that both scripts will use existing keys if present - if you need to rekey your CA or a client, remove the corresponding file.

## make-ca.sh
Generates a key (if necessary) and certificate for the certificate authority. The generated CA certificate will expire after one year.

## make-cert.sh
Generates a key (if necessary) and certificate for a user. The generated client certificate will expire after 90 days.
