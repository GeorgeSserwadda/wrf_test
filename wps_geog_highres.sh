#!/bin/bash

# Base URL for WPS geographical data (UCAR)
base_url="https://www2.mmm.ucar.edu/wrf/src/wps_files"

# Destination folder for downloads (customize this as needed)
destination_folder="./wps_geog_highres_data"

# Create the destination folder if it doesn't exist
mkdir -p "$destination_folder"

# List of geographical data sets (highest resolution) from the image
geog_files=(
  "albedo_modis.tar.bz2"
  "greenfrac_fpar_modis.tar.bz2"
  "greenfrac_fpar_modis_5m.tar.bz2"
  "lai_modis_10m.tar.bz2"
  "lai_modis_30s.tar.bz2"
  "modis_landuse_20class_30s_with_lakes.tar.bz2"
  "orogwd_10m.tar.bz2"
  "soiltemp_30s.tar.bz2"
  "soiltype_bot_30s.tar.bz2"
  "soiltype_top_30s.tar.bz2"
  "topo_gmted2010_30s.tar.bz2"  # Added back for downloading
  "varsso_10m.tar.bz2"          # Corrected file
  "varsso_5m.tar.bz2"           # Corrected file
  "varsso_2m.tar.bz2"           # Corrected file
)

# Loop through the list of files and download each
for geog_file in "${geog_files[@]}"; do
  # Construct the full URL
  file_url="${base_url}/${geog_file}"

  # Download the file
  echo "Downloading ${geog_file}..."
  if wget -O "${destination_folder}/${geog_file}" "$file_url"; then
    echo "Downloaded ${geog_file} successfully."
  else
    echo "Failed to download ${geog_file}. Skipping..."
    continue
  fi
done

# Extract the downloaded files
echo "Extracting files..."
for tar_file in ${destination_folder}/*.tar.bz2; do
  # Check if the file exists and is not corrupted
  if [[ -f "$tar_file" ]]; then
    tar -xjf "$tar_file" -C "$destination_folder" || echo "Failed to extract $tar_file."
  else
    echo "$tar_file does not exist."
  fi
done

echo "High-resolution WPS geographical data download and extraction complete."
