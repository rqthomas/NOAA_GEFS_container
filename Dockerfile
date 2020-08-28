FROM rocker/tidyverse

# Install Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	cron \
	libudunits2-dev \
	libnetcdf-dev \
	netcdf-bin && \
	R -e "install.packages(c('RCurl', 'ncdf4', 'udunits2','yaml'))"
	
RUN mkdir -p /noaa/R

COPY launch_download_downscale.R /noaa/launch_download_downscale.R
COPY rNOMADS_2.5.0.tar.gz /noaa/R/rNOMADS_2.5.0.tar.gz


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


