BEGIN {
  FS = " "
  RS = "\n"
  first = 1
  z = 0
  regs = 0
}
/^[0-9]/ {
  if (first) {
    for (x = 1; x <= NF; x++)
      columns[x] = $x
    first = 0
  } else {
    for (y = 1; y <= NF; y++) {
      if ( y == 1 )
        z++
      values[z, y] = $y
    }
    regs++
  }
}
END {
  for (i = 1; i <= regs; i++)
    for (j = 2; j <= NF; j++) {
      gsub(/\//, "_", columns[j])
      gsub(/\%/, "", columns[j])
      print columns[j]";"values[i, j]
    }
}