#!/bin/bash

timestamp=`date +%s`

for M in $(vmstat | awk -f $BASE/awk/vmstat.awk); do
    echo $M
done

exit 0