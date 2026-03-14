#!/bin/sh
 
# Sort hh.csv by created_at (col 2) then by id (col 1) in ascending order
# Keep the header, sort the rest
 
INFILE="../ex01/hh.csv"
OUTFILE="hh_sorted.csv"
 
# Extract header
head -1 "$INFILE" > "$OUTFILE"
 
# Sort remaining rows: first by created_at (field 2), then by id (field 1)
tail -n +2 "$INFILE" | sort -t',' -k2,2 -k1,1 >> "$OUTFILE"
 
echo "Done. Sorted results saved to $OUTFILE"