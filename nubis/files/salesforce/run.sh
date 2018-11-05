#!/bin/bash -l

export PATH=/usr/local/bin:$PATH

# Import from salesforce
/opt/ltv/salesforce/fetch

# Load into Vertica
/opt/ltv/salesforce/load

# Populate the summary table
/opt/ltv/salesforce/sfdc_populate_sf_summary_table.py
