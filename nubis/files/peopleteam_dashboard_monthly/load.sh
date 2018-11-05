#!/bin/bash -l

/usr/local/bin/vertica-csv-loader --start-date `date --date="1 day ago" +%Y-%m-%d` /opt/ltv/peopleteam_dashboard_monthly/load.yml
