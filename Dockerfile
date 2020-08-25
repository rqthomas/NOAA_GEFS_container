FROM rocker/tidyverse

#COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
#ENTRYPOINT ["/entrypoint.sh"]

# Install Dependencies
RUN apt-get -yq update && \
	apt-get -yqq install wget \
	git \
	libxml2-dev \
	libcurl4-openssl-dev \
	libssl-dev \
	netcdf-*\
	libnetcdf-dev\
	ssh && \
	R -e "install.packages(c('rNOMADS', 'RCurl', 'stringr', 'yaml','ncdf4', 'humidity'))" && \
	wget -O /usr/bin/yq https://github.com/mikefarah/yq/releases/download/3.2.1/yq_linux_amd64 

# Get flare-container.sh
#RUN mkdir /root/noaa && \
#	wget -O /root/noaa/rNOMADS_2.5.0.tar.gz https://raw.githubusercontent.com/rqthomas/NOAA_GEFS_container/rNOMADS_2.5.0.tar.gz && \
#	R -e "install.packages("/root/noaa/rNOMADS_2.5.0.tar.gz", repos = NULL)" 
	
# Get other R files
#RUN wget -O /root/noaa/NOAA_GEFS_download_downscale.R https://raw.githubusercontent.com/rqthomas/NOAA_GEFS_container/NOAA_GEFS_download_downscale.R && \
#	wget -O /root/noaa/temporal_downscaling.R https://raw.githubusercontent.com/rqthomas/NOAA_GEFS_container/temporal_downscaling.R && \
#	wget -O /root/noaa/write_noaa_gefs_netcdf.R https://raw.githubusercontent.com/rqthomas/NOAA_GEFS_container/write_noaa_gefs_netcdf.R

#create directory where output directory will be created	
#RUN mkdir /root/noaa/output