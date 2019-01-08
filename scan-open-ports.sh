#!/usr/bin/env bash

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ -z $1 ] ; then
  echo "Usage: `basename $0` [input-file]"
  exit 0

else
  source=$1
  iplist=$(cat $source)
  echo -e "Script run on" $(date) "\nSaving output to open-ports-$source"

  for line in $iplist
  do
    ip=$line
    var=$((var+1))
    echo -ne "Scanning host: $var\r"
    nmap --top-ports 1000 $line >> open_ports-$1.txt
  done
fi
