/average/ {
    len = split($0, array, " ")
}
{
    gsub(/\,$/, "", array[len-2])
    gsub(/\,/, ".", array[len-2])
    gsub(/\,$/, "", array[len-1])
    gsub(/\,/, ".", array[len-1])
    gsub(/\,/, ".", array[len])
}
END {
    print "1m;"array[len-2]
    print "5m;"array[len-1]
    print "15m;"array[len]
}