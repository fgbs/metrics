
COLS=""
VALS=""

head=1
for M in $(sar -b 1 1 | awk -f $BASE/awk/io.awk); do
    if [ $head -eq 1 ]; then
        COLS=( $(echo $M|sed 's/;/ /g') )
        head=0
    else
        VALS=( $(echo $M|sed 's/;/ /g') )
    fi
done

data='[{
    "name": "'$METRIC'",
    "columns": ["time", '$(echo "\"${COLS[*]}\""|sed 's/ /\", \"/g')'],
    "points": [['$(date +%s)', "all", '$(echo ${VALS[*]:1}|sed 's/ /, /g')']]
}]'

echo $data

exit 0
