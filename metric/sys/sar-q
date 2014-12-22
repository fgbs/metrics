#!/usr/bin/ksh

timestamp=`date +%s`

OLDIFS=$IFS
IFS=$(echo '\n\b')
IND=1

for LINE in $(sar -q -M 1 1 | tail -n 9 | head -n 8); do
    if [ $IND -eq 1 ]; then
        cpu=$(echo $LINE|awk '{print $2}')
        runqsz=$(echo $LINE|awk '{print $3}')
        runocc=$(echo $LINE|awk '{print $4}')
    else
        cpu=$(echo $LINE|awk '{print $1}')
        runqsz=$(echo $LINE|awk '{print $2}')
        runocc=$(echo $LINE|awk '{print $3}')
    fi
    IND=$(( IND + 1 ))

    python /opt/metrics/graph.py -m $METRIC.cpu$cpu.runqsz -v $runqsz -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.cpu$cpu.runocc -v $runocc -t $timestamp
done

IFS=$OLDIFS

exit 0
