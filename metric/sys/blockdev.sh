
COLS=()
VALS=()
rows=0

head=1
for M in $(sar -d 1 1 | awk -f $BASE/awk/blockdev.awk); do
    if [ $head -eq 1 ]; then
        COLS=( $(echo $M|sed 's/;/ /g') )
        head=0
    else
        ROW=()
        ROW=( '['$(date +%s)', "'$(echo $M|sed 's/;/\", \"/g')'"]' )
        VALS+=(${ROW[*]})
        rows=$(( rows + 1 ))
    fi
done

data='['
data+='{'
data+='"name": "'$METRIC.$P'",'
data+='"columns": ["time", '$(echo "\"${COLS[*]}\""|sed 's/ /\", \"/g')'],'
data+='"points": ['$(echo ${VALS[@]}|sed 's/\]\ \[/\],\ \[/g')']'

#if [ $idx -eq ${#PARMS[@]} ]; then
#    data+='}'
#else
    data+='},'
#fi

data+=']'

echo $rows
echo $data

exit 0