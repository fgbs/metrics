#!/bin/bash
#set -x

#BASE=/opt/metrics
BASE=$(pwd)
METRIC=""

cd $BASE
for F in $(find . -type f -name '*.sh'); do
    name=$(basename $F .sh)
    dir=$(dirname $F)

    if [ "$name" != "metrics" ]; then
        #echo "${dir#./}.$name"
        export BASE
        export METRIC="${dir#./}.$name"
        data=$($dir/$name.sh)
        
        python $BASE/lib/influxdb.py --json="$data"
    fi
done

