#!/usr/bin/env bash

run --name noaa_download -e PASSWORD=password -p 8787:8787 -v /Users/quinn/Downloads/GEFS_test:/data rqthomas/noaa_gefs_download_downscale bash /run_noaa_download_downscale.sh