#!/bin/bash

if [ "$1" == "" ]; then
  echo "usage: $0 /path/to/binary {port}"
  exit
fi

if [ "$3" != "" ]; then
  port=$3
else
  port=6666
fi

echo "running $1 on port $port"
socat TCP-LISTEN:$port,reuseaddr,fork EXEC:$1

