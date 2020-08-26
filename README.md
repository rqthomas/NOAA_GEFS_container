## NOAA GEFS downloading and temporally (6 hr to 1 hr) downscaling container

To run the container

- Pull the container from DockerHub

	`docker pull rqthomas/noaa_gefs_download_downscale:latest`

- Create a directory where you want the output saved


- Run the following, replacing `DIRECTORY_HOST_SHARED` with the output directory on your 
  machine

	`docker run -v DIRECTORY_HOST_SHARED:/data rqthomas/noaa_gefs_download_downscale bash /run_noaa_download_downscale.sh`



