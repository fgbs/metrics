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
  for (i = 2; i <= NF; i++) {
    gsub(/\%/, "", columns[i])
    printf (i < NF ? columns[i]";" : columns[i]"\n")
  }
  for (i = 2; i <= NF; i++) {
    printf (i < NF ? values[i]";" : values[i]"\n")
  }
}