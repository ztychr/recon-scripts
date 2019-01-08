#!/bin/bash

if [ "$1" == "-h" ] || [ "$1" == "--help" ] || [ -z $1 ] || [ -z $2 ] ; then
  echo "Usage: `basename $0` [ip-start] [ip-end]"
  exit 0

else
  first_ip=${1:-192.168.1.1}
  last_ip=${2:-192.168.1.254}

  echo -e "Script run on" $(date) "\nSaving output to ping-$first_ip-$last_ip.txt"

  alternate_dotted_quad_to_integer()
  {
    IFS="." read a b c d <<< `echo $1`
    echo "($a * 256 * 256 * 256) + ($b * 256 * 256) + ($c * 256) + $d" | bc
  }

  dotted_quad_to_integer()
  {
    IFS="." read a b c d <<< `echo $1`
    expr $(( (a<<24) + (b<<16) + (c<<8) + d))
  }

  integer_to_dotted_quad()
  {
    local ip=$1
    let a=$((ip>>24&255))
    let b=$((ip>>16&255))
    let c=$((ip>>8&255))
    let d=$((ip&255))
    echo "${a}.${b}.${c}.${d}"
  }

  start=$(dotted_quad_to_integer $first_ip)
  end=$(dotted_quad_to_integer $last_ip)
  for ip in `seq $start $end`
  do
    var=$((var+1))
    echo -ne "Pinged: $var\r"
    ( ping -c1 -w1 ${ip} > /dev/null 2>&1 && integer_to_dotted_quad ${ip} >> ping-$first_ip-$last_ip.txt & ) &

  done
  wait
fi
