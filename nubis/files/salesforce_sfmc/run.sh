#!/bin/bash -l

export PATH=/usr/local/bin:$PATH

# Import from salesforce
/opt/ltv/salesforce_sfmc/fetch

# Load into Vertica
/opt/ltv/salesforce_sfmc/load

# Populate the unique jobs table
/opt/ltv/salesforce_sfmc/populate_sfmc_send_jobs_unique_table.py
