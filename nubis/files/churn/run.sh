#!/bin/bash -l

set -e

/opt/ltv/churn/fetch "$@"
/opt/ltv/churn/call_load "$@"
