#!/bin/bash

COLS=""
VALS=""

case "$(uname)" in
	Darwin)
		VM="vm_stat -c 1 1"
		;;
	*)
		VM="vmstat"
		;;
esac

head=1
for M in $($VM | awk -f $BASE/awk/vmstat.awk); do
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