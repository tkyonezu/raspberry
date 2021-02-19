#!/bin/bash

FILE=0

if [ $# -ge 1 ]; then
  if [ "$1" = "-f" ]; then
    FILE=1
  fi
fi

if [ ${FILE} -eq 1 ]; then
  while :; do echo $(date +"%Y%m%d %T")','$(vcgencmd measure_clock arm |  sed "s/^.*=//") | tee -a clock.armcsv; sleep 1; done
else
  watch -n 1 vcgencmd measure_clock arm
fi

exit 0
