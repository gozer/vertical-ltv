#!/bin/bash -l

# Look at our virtualenv first
export PATH=/usr/local/virtualenvs/ltv/bin:$PATH

set -e

/opt/ltv/ltv/fetch

/opt/ltv/ltv/load_client_details

/opt/ltv/ltv/load_search_history

#/opt/ltv/ltv/test_ltv_calc_v1
/opt/ltv/ltv/ltv_calc_v1

/opt/ltv/ltv/ltv_aggr_v1

/opt/ltv/ltv/create_files

/opt/ltv/ltv/push_to_gcp
