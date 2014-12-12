#!/usr/bin/ksh
#. /opt/GNU/gnu_env

loadavg=`uptime|awk -F'average:' '{print $2}'`
lavg1m=`echo $loadavg|awk -F',' '{print $1}'`
lavg5m=`echo $loadavg|awk -F',' '{print $2}'`
lavg15m=`echo $loadavg|awk -F',' '{print $3}'`

timestamp=`date +%s`

python /opt/metrics/graph.py -m sys.loadavg.01 -v $lavg1m -t $timestamp
python /opt/metrics/graph.py -m sys.loadavg.05 -v $lavg5m -t $timestamp
python /opt/metrics/graph.py -m sys.loadavg.15 -v $lavg15m -t $timestamp

exit 0
