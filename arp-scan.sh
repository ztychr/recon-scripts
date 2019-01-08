#!/usr/bin/env bash

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ -z $1 ] || [ -z $2 ] ; then
  echo "Usage: `basename $0` [ip range start] [ip range end]"
  exit 0

else
  ipstart=$1
  ipend=$2
  echo -e "Script run on" $(date) "\nSaving output to arp-scan-$ipstart-$ipend.txt"
  arp-scan -g -q $1-$2 >> arp-scan-$1-$2.txt
fi
