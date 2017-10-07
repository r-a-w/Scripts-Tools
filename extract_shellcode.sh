#!/bin/sh

path=$1

if [ -z "$1" ]; then
  echo "usage: $0 <path to executable>"
  exit
fi

for i in $(objdump -D $1 -M intel |grep "^ "|cut -f2); do
  echo -n '\x'$i;
done;
echo


