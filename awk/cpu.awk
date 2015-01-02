BEGIN {
   FS = " "
   RS = "\n"
   first = 1
}
/^[0-9]/ {
    if (first) {
        for (x = 1; x <= NF; x++)
            columns[x] = $x
        first = 0
    } else {
        for (y = 1; y <= NF; y++)
            values[y] = $y
    }
}
END {
   for (i = 1; i <= NF; i++)
      print columns[i]";"values[i]
}