/average/ {
    len = split($0, array, " ")
}
{
    gsub(/\,$/, "", array[len-2])
    gsub(/\,$/, "", array[len-1])
}
END {
    print "one;"array[len-2]
    print "five;"array[len-1]
    print "fifteen;"array[len]
}