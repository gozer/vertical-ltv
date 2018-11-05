#!/bin/bash -l

export PATH=/usr/local/bin:$PATH

# Import from salesforce
/opt/ltv/snippets-stats/fetch

# Load into Vertica
/opt/ltv/snippets-stats/load
