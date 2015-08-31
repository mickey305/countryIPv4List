#!/bin/sh

if [ $# -ne 2 ]; then
  echo "Stoped Script: args [origin file name] [output file name]" 1>&2
  exit 1
fi

echo "cutting: $1"
sed -e "/^#/d" $1 | sed '/^ *$/d' > $2
