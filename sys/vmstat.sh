#!/usr/bin/ksh

timestamp=`date +%s`

OLDIFS=$IFS
IFS=$(echo '\n\b')

for LINE in $(vmstat 1 1 | tail -n 1); do
    procs_r=$(echo $LINE|awk '{print $1}')
    procs_b=$(echo $LINE|awk '{print $2}')
    procs_w=$(echo $LINE|awk '{print $3}')

    mem_avm=$(echo $LINE|awk '{print $4}')
    mem_free=$(echo $LINE|awk '{print $5}')

    page_re=$(echo $LINE|awk '{print $6}')
    page_at=$(echo $LINE|awk '{print $7}')
    page_si=$(echo $LINE|awk '{print $8}')
    page_so=$(echo $LINE|awk '{print $9}')
    page_pi=$(echo $LINE|awk '{print $10}')
    page_po=$(echo $LINE|awk '{print $11}')
    page_fr=$(echo $LINE|awk '{print $12}')
    page_de=$(echo $LINE|awk '{print $13}')
    page_sr=$(echo $LINE|awk '{print $14}')
    page_in=$(echo $LINE|awk '{print $15}')
    page_sy=$(echo $LINE|awk '{print $16}')
    page_cs=$(echo $LINE|awk '{print $17}')

    cpu_us=$(echo $LINE|awk '{print $18}')
    cpu_sy=$(echo $LINE|awk '{print $19}')
    cpu_id=$(echo $LINE|awk '{print $20}')

    python /opt/metrics/graph.py -m $METRIC.procs.r -v $procs_r -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.procs.b -v $procs_b -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.procs.w -v $procs_w -t $timestamp

    python /opt/metrics/graph.py -m $METRIC.mem.avm -v $mem_avm -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.mem.free -v $mem_free -t $timestamp

    python /opt/metrics/graph.py -m $METRIC.page.re -v $page_re -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.at -v $page_at -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.si -v $page_si -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.so -v $page_so -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.pi -v $page_pi -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.po -v $page_po -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.fr -v $page_fr -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.de -v $page_de -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.sr -v $page_sr -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.in -v $page_in -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.sy -v $page_sy -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.page.cs -v $page_cs -t $timestamp

    python /opt/metrics/graph.py -m $METRIC.cpu.us -v $cpu_us -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.cpu.sy -v $cpu_sy -t $timestamp
    python /opt/metrics/graph.py -m $METRIC.cpu.id -v $cpu_id -t $timestamp
done

IFS=$OLDIFS

exit 0
