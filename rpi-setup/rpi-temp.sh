#!/bin/bash

FILE=0

if [ $# -ge 1 ]; then
  if [ "$1" = "-f" ]; then
    FILE=1
  fi
fi

if [ ${FILE} -eq 1 ]; then
  while :; do echo $(date +"%Y%m%d %T")','$(vcgencmd measure_temp | tail -c +6 | sed "s/'C$//") | tee -a temperatures.csv; sleep 1; done
else
  watch -n 1 vcgencmd measure_temp
fi


exit 0
