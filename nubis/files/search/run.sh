#!/bin/bash -l

set -e

/opt/ltv/search/fetch "$@"
/opt/ltv/search/load "$@"
