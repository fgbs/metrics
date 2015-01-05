#!/bin/bash

COLS=""
VALS=""

head=1
for M in $(uptime | awk -f $BASE/awk/uptime.awk); do
    if [ $head -eq 1 ]; then
        COLS=( $(echo $M|sed 's/;/ /g') )
        head=0
    else
        VALS=( $(echo $M|sed 's/;/ /g') )
    fi
done

data='[{
    "name": "'$METRIC'",
    "columns": ["time", '$(echo "\"${COLS[*]}\""|sed 's/ /\", \"/g')'],
    "points": [['$(date +%s)', '$(echo ${VALS[*]}|sed 's/ /, /g')']]
}]'

echo $data

exit 0