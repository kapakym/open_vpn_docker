#!/bin/sh
client_name=$1
./easyrsa revoke $client_name
./easyrsa gen-crl