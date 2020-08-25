## NOAA GEFS downloading and temporally (6 hr to 1 hr) downscaling container

To run the container

- Pull the container from DockerHub

`docker pull rqthomas/noaa_gefs_download_downscale:latest`

- Switch to the bash shell

`bash`

- Set the `DIRECTORY_HOST_SHARED` environment variable in bash

`DIRECTORY_HOST_SHARED=/Users/quinn/Downloads/GEFS_test`

- Make the script you will run executable

`chmod +x run_noaa_download_downscale_host.sh`

- Run script

`./run_noaa_download_downscale_host.sh`


