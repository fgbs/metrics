#!/bin/bash

BASE=$(dirname $0)

cd $BASE
for F in $(find $BASE/sys/ -type f -name '*.sh'); do
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

