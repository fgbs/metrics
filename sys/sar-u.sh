#!/usr/bin/ksh

timestamp=`date +%s`

OLDIFS=$IFS
IFS=$(echo '\n\b')
IND=1

for LINE in $(sar -u -M 1 1 | tail -n 9 | head -n 8); do
    if [ $IND -eq 1 ]; then
        cpu=$(echo $LINE|awk '{print $2}')
        usr=$(echo $LINE|awk '{print $3}')
        sys=$(echo $LINE|awk '{print $4}')
        wio=$(echo $LINE|awk '{print $5}')
        idle=$(echo $LINE|awk '{print $6}')
    else
        cpu=$(echo $LINE|awk '{print $1}')
        usr=$(echo $LINE|awk '{print $2}')
        sys=$(echo $LINE|awk '{print $3}')
        wio=$(echo $LINE|awk '{print $4}')
        idle=$(echo $LINE|awk '{print $5}')
    fi
    IND=$(( IND + 1 ))

    python /opt/metrics/graph.py -m $METRIC.cpu$cpu.usr -v $usr -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.cpu$cpu.sys -v $sys -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.cpu$cpu.wio -v $wio -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.cpu$cpu.idle -v $idle -t $timestamp
done

IFS=$OLDIFS

exit 0
