#!/usr/bin/ksh

timestamp=`date +%s`

OLDIFS=$IFS
IFS=$(echo '\n\b')
IND=1


for LINE in $(sar -L 1 1 | grep "disk*"); do
    #echo ">> $LINE"
    if [ $IND -eq 1 ]; then
        lunpath=$(echo $LINE|awk '{print $2}')
        busy=$(echo $LINE|awk '{print $3}')
        avque=$(echo $LINE|awk '{print $4}')
        rs=$(echo $LINE|awk '{print $5}')
        ws=$(echo $LINE|awk '{print $6}')
        blkss=$(echo $LINE|awk '{print $7}')
        avwait=$(echo $LINE|awk '{print $8}')
        avserv=$(echo $LINE|awk '{print $9}')
    else
        lunpath=$(echo $LINE|awk '{print $1}')
        busy=$(echo $LINE|awk '{print $2}')
        avque=$(echo $LINE|awk '{print $3}')
        rs=$(echo $LINE|awk '{print $4}')
        ws=$(echo $LINE|awk '{print $5}')
        blkss=$(echo $LINE|awk '{print $6}')
        avwait=$(echo $LINE|awk '{print $7}')
        avserv=$(echo $LINE|awk '{print $8}')
    fi
    IND=$(( IND + 1 ))

    python /opt/metrics/graph.py -m $METRIC.$lunpath.busy -v $busy -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.$lunpath.avque -v $avque -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.$lunpath.rs -v $rs -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.$lunpath.ws -v $ws -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.$lunpath.blkss -v $blkss -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.$lunpath.avwait -v $avwait -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.$lunpath.avserv -v $avserv -t $timestamp
done

IFS=$OLDIFS

exit 0
