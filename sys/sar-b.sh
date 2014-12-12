#!/usr/bin/ksh

timestamp=`date +%s`

OLDIFS=$IFS
IFS=$(echo '\n\b')

for LINE in $(sar -b 1 1 | tail -n 1); do
    breads=$(echo $LINE|awk '{print $2}')
    lreads=$(echo $LINE|awk '{print $3}')
    rcache=$(echo $LINE|awk '{print $4}')
    bwrits=$(echo $LINE|awk '{print $5}')
    lwrits=$(echo $LINE|awk '{print $6}')
    wcache=$(echo $LINE|awk '{print $7}')
    preads=$(echo $LINE|awk '{print $8}')
    pwrits=$(echo $LINE|awk '{print $9}')

    python /opt/metrics/graph.py -m $METRIC.breads -v $breads -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.lreads -v $lreads -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.rcache -v $rcache -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.bwrits -v $bwrits -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.lwrits -v $lwrits -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.wcache -v $wcache -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.preads -v $preads -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.pwrits -v $pwrits -t $timestamp
done

IFS=$OLDIFS

exit 0
