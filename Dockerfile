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

# Get other R files
RUN wget -O /noaa/NOAA_GEFS_download_downscale.R https://raw.githubusercontent.com/rqthomas/NOAA_GEFS_container/master/NOAA_GEFS_download_downscale.R && \
	wget -O /noaa/temporal_downscaling.R https://raw.githubusercontent.com/rqthomas/NOAA_GEFS_container/master/temporal_downscaling.R && \
	wget -O /noaa/write_noaa_gefs_netcdf.R https://raw.githubusercontent.com/rqthomas/NOAA_GEFS_container/master/write_noaa_gefs_netcdf.R

# Get flare-container.sh
RUN mkdir /noaa && \
	wget -O /noaa/rNOMADS_2.5.0.tar.gz https://github.com/rqthomas/NOAA_GEFS_container/blob/master/rNOMADS_2.5.0.tar.gz && \
	R -e "install.packages("/noaa/rNOMADS_2.5.0.tar.gz", repos = NULL, type="source"))" 
	
#create directory where output directory will be created	
RUN mkdir /data