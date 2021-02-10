#!/bin/bash

while :; do echo `date +"%Y/%m/%d %T"`','`vcgencmd measure_temp | tail -c +6 | sed "s/'C//g"` | tee temperatures.csv; sleep 1; done

exit 0
