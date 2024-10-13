#!/bin/bash

# Base URL for WPS geographical data (UCAR)
base_url="https://www2.mmm.ucar.edu/wrf/src/wps_files"

# Destination folder for downloads (customize this as needed)
destination_folder="./WPS_GEOG"

# Create the destination folder if it doesn't exist
mkdir -p "$destination_folder"

# List of geographical data sets (lowest resolution) from the image
geog_files=(
  "albedo_modis.tar.bz2"                        # Albedo (MODIS, lowest resolution)
  "greenfrac_fpar_modis.tar.bz2"                # Green Fraction (FPAR, MODIS, lowest resolution)
  "modis_landuse_20class_5m_with_lakes.tar.bz2" # Land Use (MODIS, 20-class, 5-minute, with lakes)
  "orogwd_2deg.tar.bz2"                         # Orography, 2-degree (lowest resolution)
  "soiltemp_1deg.tar.bz2"                       # Soil Temperature, 1-degree
  "soiltype_bot_5m.tar.bz2"                     # Soil Type (Bottom layer), 5-minute
  "soiltype_top_5m.tar.bz2"                     # Soil Type (Top layer), 5-minute
  "topo_gmted2010_5m.tar.bz2"                   # Topography (GMTED2010, 5-minute)
  "varsso_2m.tar.bz2"                           
)

# Loop through the list of files and download each
for geog_file in "${geog_files[@]}"; do
  # Construct the full URL
  file_url="${base_url}/${geog_file}"

  # Download the file
  echo "Downloading ${geog_file}..."
  wget -O "${destination_folder}/${geog_file}" "$file_url"
done

# Extract the downloaded files
echo "Extracting files..."
for tar_file in ${destination_folder}/*.tar.bz2; do
  tar -xjf "$tar_file" -C "$destination_folder"
done

echo "Low-resolution WPS geographical data download and extraction complete."
