#!/usr/bin/ksh

#MIN=$(date +%M)
TS=$(date +%s)
#TS20MIN=$(( TS - 20 * 60 ))

#DATE1=$(python /opt/metrics/ts2date.py -t $TS -f '%H:%M:00')
#DATE2=$(python /opt/metrics/ts2date.py -t $TS20MIN -f '%H:%M:00')

#if [ $MIN -eq 00 ] || [ $MIN -eq 20 ] || [ $MIN -eq 40 ]; then
    OLDIFS=$IFS
    IFS=$(echo '\n\b')
    IND=1

    #for LINE in $(sar -d -s $DATE2 -e $DATE1 | awk '$1 ~ /[0-9]/ && $4 ~ /[0-9]/{print $1";"$2";"$3";"$4";"$5";"$6";"$7";"$8}'); do
    for LINE in $(sar -d 1 1 | awk '$1 ~ /[0-9]/ && $4 ~ /[0-9]/{print $1";"$2";"$3";"$4";"$5";"$6";"$7";"$8}'); do
        if [ $IND -eq 1 ]; then
            device=$(echo $LINE|awk -F';' '{print $2}')
            busy=$(echo $LINE|awk -F';' '{print $3}')
            avque=$(echo $LINE|awk -F';' '{print $4}')
            rws=$(echo $LINE|awk -F';' '{print $5}')
            blkss=$(echo $LINE|awk -F';' '{print $6}')
            avwait=$(echo $LINE|awk -F';' '{print $7}')
            avserv=$(echo $LINE|awk -F';' '{print $8}')
        else
            device=$(echo $LINE|awk -F';' '{print $1}')
            busy=$(echo $LINE|awk -F';' '{print $2}')
            avque=$(echo $LINE|awk -F';' '{print $3}')
            rws=$(echo $LINE|awk -F';' '{print $4}')
            blkss=$(echo $LINE|awk -F';' '{print $5}')
            avwait=$(echo $LINE|awk -F';' '{print $6}')
            avserv=$(echo $LINE|awk -F';' '{print $7}')
        fi
        IND=$(( IND + 1 ))

        python /opt/metrics/graph.py -m $METRIC.$device.busy -v $busy -t $TS
        python /opt/metrics/graph.py -m $METRIC.$device.avque -v $avque -t $TS
        python /opt/metrics/graph.py -m $METRIC.$device.rws -v $rws -t $TS
        python /opt/metrics/graph.py -m $METRIC.$device.blkss -v $blkss -t $TS
        python /opt/metrics/graph.py -m $METRIC.$device.avwait -v $avwait -t $TS
        python /opt/metrics/graph.py -m $METRIC.$device.avserv -v $avserv -t $TS
    done

    IFS=$OLDIFS
#fi

exit 0
