
COLS=()

PARMS=(DEV EDEV SOCK IP EIP ICMP EICMP TCP ETCP UDP)

for P in ${PARMS[@]}; do
    VALS=()
    head=1
    for M in $(sar -n $P 1 1 | awk -f $BASE/awk/network.awk); do
        if [ $head -eq 1 ]; then
            COLS=( $(echo $M|sed 's/;/ /g') )
            head=0
        else
            ROW=()
            ROW=( '['$(date +%s)', "'$(echo $M|sed 's/;/\", \"/g')'"],' )
            VALS+=(${ROW[*]})
        fi
    done

    POINTS=${VALS[@]}
    data='[{
        "name": "'$METRIC.$P'",
        "columns": ["time", '$(echo "\"${COLS[*]}\""|sed 's/ /\", \"/g')'],
        "points": ['${VALS[@]}']}]'

    echo $data
done

exit 0