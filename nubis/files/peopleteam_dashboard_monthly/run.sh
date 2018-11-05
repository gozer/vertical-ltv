#!/bin/bash -l

export PATH=/usr/local/bin:$PATH

# Import from Workday
/opt/ltv/peopleteam_dashboard_monthly/fetch

# Load into Vertica
/opt/ltv/peopleteam_dashboard_monthly/load
