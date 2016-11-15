#! /bin/bash
#
## Repo Location
repo="/home/mdweems/Senior Design/repo/"

###############################################################################
## Communicate with RADA ##

# Connect to RADA over Wifi
# TODO

# wait for RADA to send LiDAR data
# then shove it into a csv
#./post

###############################################################################
## Communicate with GoPro ##

# Connect to GoPro over Wifi
# TODO

# pull list of images from GoPro
#curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://10.5.5.9:8080/videos/DCIM/100GOPRO/ > dir.html

# parse list of images into text file
#cat dir.html | sed -n 's/.*\(GOPR0[0-9]*.JPG\).*/\1/p' > imglist.txt

# pull images off the GoPro
# will create a list of files
# need to move them to matlab dir
#./get_pic

###############################################################################
## sync data then move to matlab scripts ##

# copy images to matlab dir
find . -name \*.JPG -exec cp {} ../../angledCameraMethod/test_images/ \;
rm ../../angledCameraMethod/test_images/temp.JPG

# sync LiDAR data and image filenames and add them to a csv
ls -1v *.JPG > jpg_list
./sync_data

# copy lidar_data.csv to matlab dir
cp ld.csv ../../angledCameraMethod/lidar_data.csv

# cd to matlab dir
cd ../../angledCameraMethod

###############################################################################
## Run Image Analysis ##

# run the matlab scripts with this csv as input
echo Running Matlab
matlab  -r "run $repo/angledCameraMethod/run.m"
# -nodisplay -nodesktop

###############################################################################
## Store LiDAR data and Images for future reference ##

## need to add functionality to account for multiple runs per day

# current time
now=$(date +"%m_%d_%Y")

# move images to new DIR
cd test_images
mkdir $now 2>/dev/null
find . -name \*.JPG -exec mv {} $now \;  2>/dev/null

# move lidar data to new DIR
mv ../lidar_data.csv $now/lidar_data.csv 2>/dev/null

cd ..

###############################################################################
## Finish up ##

# cd back to script dir
cd ../arduinoCloseLoop/linux_server
