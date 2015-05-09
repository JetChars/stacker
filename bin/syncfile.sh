#!/bin/bash

HOSTS='r16s04 r16s03 r16s02 r16s01'

if [ $# -eq 0 ]; then
  echo file required!
  exit 1
else
  for HOST in $HOSTS;do
    scp $1 $HOST:$1
  done
fi
