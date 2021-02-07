#!/bin/sh
conf_dir="./server_config/"
./easyrsa init-pki

./easyrsa build-ca

cp ./pki/ca.crt $conf_dir

./easyrsa gen-req server nopass

./easyrsa sign-req server server

./easyrsa gen-dh

cp ./pki/issued/server.crt $conf_dir
cp ./pki/private/server.key $conf_dir

./easyrsa gen-dh

cp ./pki/dh.pem $conf_dir

exit