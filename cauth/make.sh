#!/bin/sh

center=$1

if [ "$center" = "" ]; then
  echo "missing CA name" 1>&2
  exit
fi

docker build -t $center .

exit
