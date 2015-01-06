
COLS=()

PARMS=(DEV EDEV SOCK IP EIP ICMP EICMP TCP ETCP UDP)

idx=0
data='['
for P in ${PARMS[@]}; do
    VALS=()
    head=1
    for M in $(sar -n $P 1 1 | awk -f $BASE/awk/network.awk); do
        if [ $head -eq 1 ]; then
            COLS=( $(echo $M|sed 's/;/ /g') )
            head=0
        else
            ROW=()
            ROW=( '['$(date +%s)', "'$(echo $M|sed 's/;/\", \"/g')'"]' )
            VALS+=(${ROW[*]})
        fi
    done

    idx=$(( idx + 1 ))

    data+='{'
    data+='"name": "'$METRIC.$P'",'
    data+='"columns": ["time", '$(echo "\"${COLS[*]}\""|sed 's/ /\", \"/g')'],'
    data+='"points": ['$(echo ${VALS[@]}|sed 's/\]\ \[/\],\ \[/g')']'

    if [ $idx -eq ${#PARMS[@]} ]; then
        data+='}'
    else
        data+='},'
    fi
done

data+=']'
echo $data

exit 0