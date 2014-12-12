#!/usr/bin/ksh

BASE=/opt/metrics
METRIC=""

cd $BASE
for F in $(find . -type f -name '*.sh'); do
    name=$(basename $F .sh)
    dir=$(dirname $F)

    if [ "$name" != "metrics" ]; then
        #echo "${dir#./}.$name"
        export METRIC="${dir#./}.$name"
        $dir/$name.sh
    fi
done

