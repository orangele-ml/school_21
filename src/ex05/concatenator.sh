#!/bin/sh
 
# concatenator.sh
# Concatenates all date-partitioned CSV files (YYYY-MM-DD.csv) back into one file.
# The result is equivalent to hh_positions.csv from Exercise 03.
 
OUTFILE="hh_concatenated.csv"
 
# Find all date-partitioned CSV files (matching YYYY-MM-DD.csv pattern), sorted
FILES=$(ls [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].csv 2>/dev/null | sort)
 
if [ -z "$FILES" ]; then
    echo "No partitioned CSV files found. Run partitioner.sh first."
    exit 1
fi
 
# Write header from first file
FIRST=$(echo "$FILES" | head -1)
head -1 "$FIRST" > "$OUTFILE"
 
# Append data rows from all files in order
for f in $FILES; do
    tail -n +2 "$f" >> "$OUTFILE"
done
 
echo "Done. Concatenated result saved to $OUTFILE"
 