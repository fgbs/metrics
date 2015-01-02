
COLS=""
VALS=""

idx=0
for M in $(sar -u 1 1 | awk -f $BASE/awk/cpu.awk); do
    col=$(echo $M|awk -F';' '{print $1}')
    val=$(echo $M|awk -F';' '{print $2}')

    COLS[$idx]=$col
    VALS[$idx]=$val

    idx=$(( idx + 1 ))
done

data='[{
    "name": "'$METRIC'",
    "columns": ["time", '$(echo "\"${COLS[*]:2}\""|sed 's/ /\", \"/g')'],
    "points": [['$(date +%s)', '$(echo ${VALS[*]:2}|sed 's/ /, /g')']]
}]'

echo $data

exit 0