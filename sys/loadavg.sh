#!/bin/bash

data='[{
    "name": "'$(basename $0 .sh)'",
    "columns": ["time", "hostname", "1m", "5m", "15m"],
    "points": [['$(date +%s)', "'$(hostname)'", '$(uptime | awk -f $BASE/awk/uptime.awk)']]
}]'

echo $data

exit 0