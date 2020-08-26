##' @title Script to launch NOAA download and temporal downscaling
##' @return None
##' @param none, full path to 6hr file
##' @export
##' 
##' @author Quinn Thomas
##' 
##' 

library(rNOMADS)
library(tidyverse)

#Use these for using code on local machine
#source("/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/write_noaa_gefs_netcdf.R")
#source("/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/temporal_downscaling.R")
#source("/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/download_downscale_site.R")
#output_directory <- "/Users/quinn/Downloads/GEFS_test"
#configuration_yaml <- "/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/noaa_config/Downloads/GEFS_test"

#source files and set paths on container
#these directories won't change on container
source("/noaa/write_noaa_gefs_netcdf.R")
source("/noaa/temporal_downscaling.R")
source("/noaa/download_downscale_site.R")
output_directory <- "/data"
configuration_yaml <- "/noaa_config/noaa_download_scale_config.yml"



#Set model name
model_name <- "NOAAGEFS"
model_name_ds <-"NOAAGEFStimeds" #Downscaled NOAA GEFS

#Read configuration file
config_file <- yaml::read_yaml(configuration_yaml)

#Read list of latitude and longitudes
neon_sites <- readr::read_csv(config_file$site_file, col_types = cols())
site_list <- neon_sites$site_id
lat_list <- neon_sites$latitude
lon_list <- neon_sites$longitude

overwrite <- config_file$overwrite

run_parallel <- config_file$run_parallel

print(paste0("Site file: ", config_file$site_file))
print(paste0("Overwrite existing files: ", config_file$overwrite))
print(paste0("Running in parallel: ", config_file$run_parallel))

if(run_parallel){
  
  #Create cluster
  numCores <- config_file$numCores
  if(numCores > parallel::detectCores()){
    #Docker sets the max number of cores, if the request is for more, set to 
    #what docker allows
    numCores <- parallel::detectCores()
    
  }
  print(paste0("Number of cores specified: ", config_file$numCores))
  print(paste0("Number of cores allocated: ", numCores))
  
  
  site_index <- 1:length(site_list)
  
  #Run download_downscale_site() over the site_index
  parallel::mclapply(X = site_index, 
                     FUN = download_downscale_site, 
                     lat_list = lat_list,
                     lon_list = lon_list,
                     site_list = site_list,
                     overwrite = overwrite,
                     model_name = model_name,
                     model_name_ds = model_name_ds, 
                     output_directory = output_directory, 
                     mc.cores = numCores)
  
}else{
  
  for(site_index in 1:length(site_list)){
    
    download_downscale_site(site_index,
                            lat_list = lat_list,
                            lon_list = lon_list,
                            site_list = site_list,
                            overwrite = overwrite,
                            model_name = model_name,
                            model_name_ds = model_name_ds,
                            output_directory = output_directory)
  }
}

