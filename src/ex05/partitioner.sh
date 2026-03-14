#!/bin/sh
 
# partitioner.sh
# Splits hh_positions.csv into separate CSV files per unique date in created_at column.
# Output files are named by date: YYYY-MM-DD.csv
 
INFILE="../ex03/hh_positions.csv"
HEADER=$(head -1 "$INFILE")
 
# Get all unique dates (YYYY-MM-DD prefix of created_at field)
tail -n +2 "$INFILE" | while IFS= read -r line; do
    # Extract created_at (2nd field), get just the date part (first 10 chars)
    created_at=$(echo "$line" | sed 's/^"[^"]*","\([^"]*\)".*/\1/')
    date=$(echo "$created_at" | cut -c1-10)
 
    outfile="${date}.csv"
 
    # Write header if file doesn't exist yet
    if [ ! -f "$outfile" ]; then
        echo "$HEADER" > "$outfile"
    fi
 
    echo "$line" >> "$outfile"
done
 
echo "Done. Partitioned files created."
ls -1 *.csv 2>/dev/null