#!/bin/sh
 
# Convert hh.json from ex00 to CSV using the jq filter
jq -r -f filter.jq ../ex00/hh.json > hh.csv
 
echo "Done. Results saved to hh.csv"
