#! /bin/bash
#
# wait for RADA to send LiDAR data
# then shove it into a csv
./post

# pull list of images from GoPro
curl -i -H "Accept: application/json" -H "Content-Type: application/json" http://10.5.5.9:8080/video/DCIM/GOPR0100 > dir.html

# parse list of images into text file
cat dir.html | sed -n 's/.*\(GOPR0[0-9]+.JPG\).*/\1/p' > imglist.txt

# pull images off the GoPro
# will create a list of files
# need to move them to matlab dir
cat imglist.txt | ./get_pic


# cd to matlab dir
# sync LiDAR data and image filenames and add them to a csv
# run the matlab scripts with this csv as input


