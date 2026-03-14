#!/bin/sh
 
# Check that an argument was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <vacancy_name>"
    echo "Example: $0 \"data scientist\""
    exit 1
fi
 
VACANCY_NAME="$1"
 
# URL-encode the vacancy name by replacing spaces with %20
ENCODED_NAME=$(echo "$VACANCY_NAME" | sed 's/ /%20/g')
 
# Fetch first 20 vacancies from HeadHunter API and format JSON (each field on a new line)
curl -s "https://api.hh.ru/vacancies?text=${ENCODED_NAME}&per_page=20" \
    -H "User-Agent: api-test-agent" \
    | jq '.' > hh.json
 
echo "Done. Results saved to hh.json"