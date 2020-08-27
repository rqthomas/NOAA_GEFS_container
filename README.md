## NOAA GEFS downloading and temporally (6 hr to 1 hr) downscaling container

## Quickstart

Set the OUTDIR to your preferred output location in the `Makefile`.
Run: 

```bash
make
```

to build the container and start the CRON job to generate data every 6 hrs.  

**Configuration**: 
- edit `hello-cron` to adjust the cron timing.
- edit the site configuration in the `example` directory as described below.

### To run the container

- Pull the container from DockerHub

	`docker pull rqthomas/noaa_gefs_download_downscale:latest`

- Create a directory where you want the output saved

- Create a directory where you want the configuration files stored and move the following
  files into the directory. Examples of the files can be found in the `example` directory
  on GitHub
  
  - noaa_download_scale_config.yml
  - noaa_download_site_list.csv
  
- Edit the noaa_download_scale_config.yml

  - `site_file:` is the file name in your configuration directory (i.e., noaa_download_site_list.csv)
     or the web address of a file (i.e., https://raw.githubusercontent.com/rqthomas/NOAA_GEFS_container/master/noaa_download_site_list.csv)
  - `run_parallel:` TRUE = download and process using multiple cores; FALSE = use single core
  - `numCores:` If `run_parallel`  is TRUE , specify number of cores to use
  - `overwrite:` TRUE = overwrite existing files, FALSE = don't overwrite

- Run the following, replacing `DIRECTORY_HOST_SHARED` with the output directory on your 
  machine and `DIRECTORY_HOST_CONFIG` with your configuration directory

	`docker run -v DIRECTORY_HOST_SHARED:/noaa/data -v DIRECTORY_HOST_CONFIG:/noaa/config rqthomas/noaa_gefs_download_downscale bash /run_noaa_download_downscale.sh`
