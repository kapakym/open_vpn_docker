#!/bin/bash
user_name=$1
./easyrsa gen-req $user_name nopass
./easyrsa sign-req client $user_name
./client_config.sh $user_name

