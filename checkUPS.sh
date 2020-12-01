#!/bin/bash

echo "$(date +%d-%m-%Y,%H:%M:%S),Power check"
POWERLEVEL=$(/usr/sbin/pwrstat -status | grep Capacity | grep -oP "\d{1,3}")
EXIT="$?"

if [ "$EXIT" -eq 0 ]; then
  if [ "$POWERLEVEL" -lt 20 ]; then
    echo "$(date +%d-%m-%Y,%H:%M:%S),$POWERLEVEL (LOW)"
    echo "$(date +%d-%m-%Y,%H:%M:%S),Shutting machine down in 60 seconds"
    sleep 30
    echo "$(date +%d-%m-%Y,%H:%M:%S),Shutting machine down in 30 seconds"
    sleep 30
    echo "$(date +%d-%m-%Y,%H:%M:%S),Shutting down now"
    sudo init 0
  else
    echo "$(date +%d-%m-%Y,%H:%M:%S),$POWERLEVEL (NOMINAL)"
  fi
else
  echo "$(date +%d-%m-%Y,%H:%M:%S),ERROR: Could not get power status"
fi
