#!/bin/bash -l

set -e

/opt/ltv/adi_by_region/fetch

# Run for previous month
/opt/ltv/adi_by_region/load $(date --date="7 day ago" +%Y-%m-%d)
