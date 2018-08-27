#!/bin/bash

function pi-stat {
  HOST=$1

  if [ "${HOST}" != "localhost" ]; then
    RHOST="ssh ${HOST}"
  fi

  TEMP=$(${RHOST} vcgencmd measure_temp | sed "s/^.*=//")
  CLOCK=$(${RHOST} vcgencmd measure_clock arm | sed "s/^.*=//")
  VOLTS=$(${RHOST} vcgencmd measure_volts | sed "s/^.*=//")

  if [ "${HOST}" = "localhost" ]; then
    echo "$(hostname): ${TEMP} ${CLOCK} ${VOLTS}"
  else
    echo "${HOST}: ${TEMP} ${CLOCK} ${VOLTS}"
  fi
}

pi-stat localhost

exit 0
