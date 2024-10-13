#!/bin/bash
# Base URL for GFS data
base_url="https://nomads.ncep.noaa.gov/dods/gfs_1p00"

# Destination folder for downloads (you can customize this)
destination_folder="./GFS"

# Create the destination folder if it doesn't exist
mkdir -p "$destination_folder"

# Initialize counters and lists for tracking
declare -a downloaded_files
declare -a deleted_files

# Loop over the past 4 days
for day_offset in {0..3}; do
  # Calculate the date for the forecast
  forecast_date=$(date -d "-$day_offset days" +%Y%m%d)

  # Loop through the forecast times (00z, 06z, 12z, 18z)
  for hour in 00 06 12 18; do
    # Construct the URL for the current forecast time
    file_url="${base_url}/gfs${forecast_date}/gfs_1p00_${hour}z"
    
    # Construct the output file name
    output_file="${destination_folder}/gfs_1p00_${forecast_date}_${hour}z"
    
    # Download the GFS data
    wget -O "$output_file" "$file_url"

    # Check if the file size is less than 100 KB (102400 bytes)
    if [[ -f "$output_file" ]]; then
      file_size=$(stat -c%s "$output_file")
      
      if [[ $file_size -lt 102400 ]]; then
        echo "File $output_file is smaller than 100KB ($file_size bytes), deleting..."
        rm -f "$output_file"
        deleted_files+=("$output_file")
      else
        echo "File $output_file is okay with size $file_size bytes."
        downloaded_files+=("$output_file")
      fi
    else
      echo "Error: File $output_file not found after download!"
      deleted_files+=("$output_file (not available)")
    fi
  done
done

# Summary of downloaded and deleted files
echo
echo "Download Summary:"
echo "-------------------------"
echo "Downloaded files:"
for file in "${downloaded_files[@]}"; do
  echo "$file"
done

echo
echo "Deleted or unavailable files:"
for file in "${deleted_files[@]}"; do
  echo "$file"
done
