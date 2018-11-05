#!/bin/bash

FETCH_DATE=$(date +%Y-%m-%d) # default is to process for current date

XFER_FILE_DIR=/var/lib/ltv/churn/latest/work
set -e

for file in "$XFER_FILE_DIR"/*.csv.gz
do
	# pass file to python script to load
	/opt/ltv/churn/load -f "$file" -d "$FETCH_DATE"
done
