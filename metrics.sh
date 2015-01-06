#!/bin/bash

export LANG=C
BASE=$(dirname $0)

cd $BASE
for F in $(find $BASE/metric/ -type f -name '*.sh'); do
    name=$(basename $F .sh)
    dir=$(basename $(dirname $F))

    export BASE
    export METRIC="$(hostname -s).${dir#./}.$name"
    data=$($BASE/metric/$dir/$name.sh)

    python $BASE/lib/influxdb.py --json="$data"
done

