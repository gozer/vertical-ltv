#!/bin/bash -l

/usr/local/bin/peopleteam-dashboard-fetcher --output-dir /var/lib/ltv/peopleteam_dashboard/ --date `date --date="1 day ago" +%Y-%m-%d`
