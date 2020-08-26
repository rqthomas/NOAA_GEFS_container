
library(rNOMADS)
library(tidyverse)

#source("/Users/quinn/Dropbox (VTFRS)/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/write_noaa_gefs_netcdf.R")
#source("/Users/quinn/Dropbox (VTFRS)/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/temporal_downscaling.R")
#source("/Users/quinn/Dropbox (VTFRS)/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/download_downscale_site.R")
#output_directory <- "/Users/quinn/Downloads/GEFS_test"

source("/noaa/write_noaa_gefs_netcdf.R")
source("/noaa/temporal_downscaling.R")
source("/noaa/download_downscale_site.R")
output_directory <- "/data"

config_file <- yaml::read_yaml(paste0("/noaa_config/noaa_download_scale_config.yml"))

neon_sites <- readr::read_csv(config_file$site_file, col_types = cols())
model_name <- "NOAAGEFS"
model_name_ds <-"NOAAGEFStimeds"

site_list <- neon_sites$site_id
lat.in <- neon_sites$latitude
lon.in <- neon_sites$longitude
overwrite <- config_file$overwrite

run_parallel <- config_file$run_parallel

print(paste0("Site file: ", config_file$site_file))
print(paste0("Overwrite existing files: ", config_file$overwrite))
print(paste0("Running in parallel: ", config_file$run_parallel))

if(config_file$run_parallel) print(paste0("Number of cores: ", config_file$numCores))



#####

if(run_parallel){
  
  numCores <- config_file$numCores
  if(numCores > parallel::detectCores()){
    numCores <- parallel::detectCores()

  }
  print(paste0("Number of cores specified: ", config_file$numCores))
  print(paste0("Number of cores allocated: ", numCores))
  
  
  site_index <- 1:length(site_list)
  
  parallel::mclapply(X = site_index, 
                     FUN = download_downscale_site, 
                     lat.in = lat.in,
                     lon.in = lon.in,
                     overwrite = overwrite,
                     model_name = model_name,
                     model_name_ds = model_name_ds, 
                     output_directory = output_directory, 
                     mc.cores = numCores)
  
}else{
  
  for(site_index in 1:length(site_list)){
    
    download_downscale_site(site_index,
                            lat.in = lat.in,
                            lon.in = lon.in,
                            overwrite = overwrite,
                            model_name = model_name,
                            model_name_ds = model_name_ds,
                            output_directory = output_directory)
  
    }
  
}

