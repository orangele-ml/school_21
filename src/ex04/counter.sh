#!/bin/sh
 
# counter.sh
# Counts unique values in the name column of hh_positions.csv,
# sorts by count descending, saves to hh_uniq_positions.csv.
 
INFILE="../ex03/hh_positions.csv"
OUTFILE="hh_uniq_positions.csv"
 
# Write header
echo '"name","count"' > "$OUTFILE"
 
# Extract name column (3rd field), skip header, count unique values, sort descending
tail -n +2 "$INFILE" \
    | sed 's/^"[^"]*","[^"]*","\([^"]*\)".*/\1/' \
    | sort \
    | uniq -c \
    | sort -rn \
    | awk '{count=$1; $1=""; name=substr($0,2); print "\"" name "\"," count}' \
    >> "$OUTFILE"
 
echo "Done. Results saved to $OUTFILE"
 