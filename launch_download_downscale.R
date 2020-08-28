
#Use these for using code on local machine
#output_directory <- "/Users/quinn/Downloads/GEFS_test"
#configuration_yaml <- "/Users/quinn/Dropbox/Research/EFI_RCN/NOAA_GEFS_download/NOAA_GEFS_container/example/noaa_download_scale_config.yml"

#source files and set paths on container
#these directories won't change on container


output_directory <- "/noaa/data"
configuration_yaml <- "/noaa/config/noaa_download_scale_config.yml"

#Read configuration file
config_file <- yaml::read_yaml(configuration_yaml)

#Read list of latitude and longitudes
neon_sites <- readr::read_csv(config_file$site_file)
site_list <- neon_sites$site_id
lat_list <- neon_sites$latitude
lon_list <- neon_sites$longitude

print(paste0("Site file: ", config_file$site_file))

noaaGEFSpoint::noaa_gefs_download_downscale(site_list,
                                            lat_list,
                                            lon_list,
                                            output_directory,
                                            forecast_time = config_file$forecast_time,
                                            forecast_date = config_file$forecast_date,
                                            latest = config_file$latest,
                                            downscale = config_file$downscale,
                                            run_parallel = config_file$run_parallel,
                                            num_cores = config_file$num_cores,
                                            overwrite = config_file$overwrite)

