#!/bin/bash

COLS=""
VALS=""

idx=0
for M in $(vmstat | awk -f $BASE/awk/vmstat.awk); do
    col=$(echo $M|awk -F';' '{print $1}')
    val=$(echo $M|awk -F';' '{print $2}')

    COLS[$idx]=$col
    VALS[$idx]=$val

    idx=$(( idx + 1 ))
done

data='[{
    "name": "'$(basename $0 .sh)'",
    "columns": ["time", "hostname", '$(echo "\"${COLS[*]}\""|sed 's/ /\", \"/g')'],
    "points": [['$(date +%s)', "'$(hostname)'", '$(echo ${VALS[*]}|sed 's/ /, /g')']]
}]'

echo $data

exit 0