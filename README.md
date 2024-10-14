Scripts to download wrf model data like GFS and WPS_GEOGRAPHY (WPS_GEOG)

In order to run the scripts (via linux os) ensure that they are executables by using the command 
  
    chmod +x gfs_data_download.sh 
    chmod +x wps_geog_lowresolution.sh
    chmod +x wps_geog_highres.sh

To run the script simply type the following command in your terminal

    ./gfs_data_download.sh 
    ,/wps_geog_lowresolution.sh
    ./wps_geog_highres.sh

Note that you only need to run WPS_GEOG scripts once but you will need run the GFS scripts whenever you need to use the most rescent GFS data

Downlod WPS data from https://github.com/wrf-model/WPS
 
    git clone https://github.com/wrf-model/WPS

Download a wrfdomainwizard and use it to generate a desired wrf domain utilizing the file path for WPS, WPS_GEOG, and set a file path for the DOMAIN to be created

Download WRF docker image from any of the links below

https://hub.docker.com/r/0902vrlt/wrf-3dvar

    docker pull 0902vrlt/wrf-3dvar 

https://hub.docker.com/r/thmamouka/wrf-3dvar 

    docker pull thmamouka/wrf-3dvar 
  
Launch the Docker Container: 
  
    docker run -it --rm \thmamouka/wrf-3dvar:4.5 bash

Or Run the Docker container with the following command which links the earlier downloaded data folders to wrf docker container:

Assuming that my WRF data files on the local computer are on the PATH: "/home/george/wrf_model/wrf_test"

    docker run -it --rm \
    -v /home/george/wrf_model/wrf_test/WPS_GEOG:/wrf_data/WPS_GEOG:ro \
    -v /home/george/wrf_model/wrf_test/DOMAIN:/wrf_data/DOMAIN:ro \
    -v /home/george/wrf_model/wrf_test/GFS:/wrf_data/GFS:ro \
    -v /home/george/wrf_model/wrf_test/output:/wrf/WRF/run/output \
    thmamouka/wrf-3dvar:4.5 bash
This command mounts your host directories (in wrf_test) to the Docker container.


  
