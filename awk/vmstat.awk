BEGIN {
   FS = " "
   RS = "\n"
}
{
   if (NR > 1) {
      if ($1 == "r" || $1 == "free") {
         for (x = 1; x <= NF; x++)
            columns[x] = $x
      } else {
         for (y = 1; y <= NF; y++)
            values[y] = $y
      }
   }
}
END {
   for (i = 1; i <= NF; i++)
      printf (i < NF ? columns[i]";" : columns[i]"\n")
   for (i = 1; i <= NF; i++)
      printf (i < NF ? values[i]";" : values[i]"\n")
}