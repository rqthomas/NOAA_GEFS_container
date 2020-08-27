FROM rocker/tidyverse

# Install Dependencies
RUN apt-get -yq update && \
	apt-get -yqq install \
	cron \
	git \
	libxml2-dev \
	libcurl4-openssl-dev \
	libssl-dev \
	libudunits2-dev \
	libnetcdf-dev \
	netcdf-* \
	ssh \
        wget && \
	R -e "install.packages(c('rNOMADS', 'RCurl', 'stringr', 'yaml','ncdf4', 'udunits2','yaml','devtools'))" && \
	wget -O /usr/bin/yq https://github.com/mikefarah/yq/releases/download/3.2.1/yq_linux_amd64 
	
RUN mkdir -p /noaa/R

COPY launch_download_downscale.R /noaa/launch_download_downscale.R
COPY rNOMADS_2.5.0.tar.gz /noaa/R/rNOMADS_2.5.0.tar.gz
COPY run_noaa_download_downscale.sh /run_noaa_download_downscale.sh

COPY R/rNOMADS_2.5.0.tar.gz /noaa/R/rNOMADS_2.5.0.tar.gz

COPY hello-cron /etc/cron.d/hello-cron
RUN chmod 0644 /etc/cron.d/hello-cron && \
    crontab /etc/cron.d/hello-cron

# Get flare-container.sh
RUN R -e "install.packages('/noaa/R/rNOMADS_2.5.0.tar.gz', repos = NULL)"
RUN R -e "devtools::install_github('rqthomas/noaaGEFSpoint')"
	
#create directory where output directory will be created	
RUN mkdir -p /noaa/data
#create directory where configuration files will be located
RUN mkdir -p /noaa/config

# Run the command on container startup
CMD ["cron", "-f"]


