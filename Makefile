## Set OUTDIR to your perferred directory!
## Edit the configuration in the example/ directory to select your sites (optional)
## Run `make`

.PHONY: example
HERE=$(shell pwd)
OUTDIR=${OUTDIR:=$HERE}

example:
	docker build -t rqthomas/noaa_gefs_download_downscale . 
	docker run -v $(OUTDIR)/data:/noaa/data -v $(HERE)/example/:/noaa/config rqthomas/noaa_gefs_download_downscale

