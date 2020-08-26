
library(tidyverse)

#Use these for using code on local machine
#source("/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/R/write_noaa_gefs_netcdf.R")
#source("/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/R/temporal_downscaling.R")
#source("/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/R/download_downscale_site.R")
#source("/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/R/noaa_gefs_download_downscale.R")
#output_directory <- "/Users/quinn/Downloads/GEFS_test"
#configuration_yaml <- "/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/example/noaa_download_scale_config.yml"

#source files and set paths on container
#these directories won't change on container
source("/noaa/R/write_noaa_gefs_netcdf.R")
source("/noaa/R/temporal_downscaling.R")
source("/noaa/R/download_downscale_site.R")
source("/noaa/R/noaa_gefs_download_downscale.R")

output_directory <- "/noaa/data"
configuration_yaml <- "/noaa/config/noaa_download_scale_config.yml"

#Read configuration file
config_file <- yaml::read_yaml(configuration_yaml)

#Read list of latitude and longitudes
neon_sites <- readr::read_csv(config_file$site_file, col_types = cols())
site_list <- neon_sites$site_id
lat_list <- neon_sites$latitude
lon_list <- neon_sites$longitude

overwrite <- config_file$overwrite

run_parallel <- config_file$run_parallel

num_cores <- config_file$num_cores

downscale <- config_file$downscale

print(paste0("Site file: ", config_file$site_file))

noaa_gefs_download_downscale(site_list,
                             lat_list,
                             lon_list,
                             output_directory,
                             downscale,
                             run_parallel = run_parallel,
                             num_cores = num_cores, 
                             overwrite = FALSE)

