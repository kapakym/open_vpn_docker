#!/bin/sh

server=$1

if [ "$server" = "" ]; then
  echo "missing server name" 1>&2
  exit
fi

docker build -t $server .

exit
