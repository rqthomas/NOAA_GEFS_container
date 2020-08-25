#!/usr/bin/env bash

docker run --name flare-dev -e PASSWORD=password -p 8787:8787 -v /Users/quinn/Downloads/GEFS_test:/data rqthomas/noaa_gefs_download_downscale