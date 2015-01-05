/average/ {
    len = split($0, array, " ")
}
{
    gsub(/\,$/, "", array[len-2])
    gsub(/\,$/, "", array[len-1])
}
END {
    print "one;five;fifteen"
    print array[len-2]";"array[len-1]";"array[len]
}