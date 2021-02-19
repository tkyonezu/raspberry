#!/bin/bash

pi-stat() {
  TEMP=$(${RHOST} vcgencmd measure_temp | sed "s/^.*=//")
  CLOCK=$(${RHOST} vcgencmd measure_clock arm | sed "s/^.*=//")
  VOLTS=$(${RHOST} vcgencmd measure_volts | sed "s/^.*=//")

  echo "$(date +"%Y%m%d %T"): ${TEMP} ${CLOCK} ${VOLTS}"
}

FILE=0

if [ $# -ge 1 ]; then
  if [ "$1" = "-f" ]; then
    FILE=1
  fi
fi

if [ ${FILE} -eq 1 ]; then
  while :; do pi-stat | tee -a rpi-stat.csv; sleep 1; done
else
  while :; do pi-stat; sleep 1; done
fi

exit 0
