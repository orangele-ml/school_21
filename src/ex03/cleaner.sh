#!/bin/sh
 
# cleaner.sh
# Extracts Junior, Middle, or Senior from the name column.
# If none found, replaces with "-".
# If multiple found (e.g. "Middle/Senior"), keeps them joined by "/".
 
INFILE="../ex02/hh_sorted.csv"
OUTFILE="hh_positions.csv"
 
# Write header
head -1 "$INFILE" > "$OUTFILE"
 
# Process each data row
tail -n +2 "$INFILE" | while IFS= read -r line; do
    # Extract name (3rd quoted field) using sed
    name=$(echo "$line" | sed 's/^"[^"]*","[^"]*","\([^"]*\)".*/\1/')
 
    # Find Junior, Middle, Senior in order
    position=""
    for word in Junior Middle Senior; do
        if echo "$name" | grep -q "$word"; then
            if [ -z "$position" ]; then
                position="$word"
            else
                position="${position}/${word}"
            fi
        fi
    done
 
    # Default to "-" if none found
    [ -z "$position" ] && position="-"
 
    # Replace the 3rd CSV field using Python for robustness (handles slashes, special chars)
    new_line=$(python3 -c "
import sys
line = sys.argv[1]
position = sys.argv[2]
# Manual CSV split to preserve original quoting style
parts = []
in_q = False
cur = ''
for c in line:
    if c == '\"':
        in_q = not in_q
        cur += c
    elif c == ',' and not in_q:
        parts.append(cur)
        cur = ''
    else:
        cur += c
parts.append(cur)
# Replace 3rd field (index 2)
parts[2] = '\"' + position + '\"'
print(','.join(parts))
" "$line" "$position")
 
    echo "$new_line" >> "$OUTFILE"
done
 
echo "Done. Cleaned results saved to $OUTFILE"