#!/bin/bash

COLS=""
VALS=""

idx=0
for M in $(uptime | awk -f $BASE/awk/uptime.awk); do
    col=$(echo $M|awk -F';' '{print $1}')
    val=$(echo $M|awk -F';' '{print $2}')

    COLS[$idx]=$col
    VALS[$idx]=$val

    idx=$(( idx + 1 ))
done

data='[{
    "name": "'$METRIC'",
    "columns": ["time", '$(echo "\"${COLS[*]}\""|sed 's/ /\", \"/g')'],
    "points": [['$(date +%s)', '$(echo ${VALS[*]}|sed 's/ /, /g')']]
}]'

echo $data

exit 0