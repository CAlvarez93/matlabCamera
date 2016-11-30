This directory contains the code the run a loop on a UNIX machine to accept data from RADA and a GoPro. It will run this data through the height measurement matlab scripts, and then archive the results in the respective folders. <br />

Script breakdown: <br />

run: <br />
<md-tab>Master script. Will run the whole process for you.</md-tab>

post.c: <br />
<md-tab>Listens for the post data sent from RADA. Contains the LiDAR information.</md-tab>

get_pic.cpp: <br />
<md-tab>Downloads all of the images from the GoPro into the current directory.</md-tab>

sync_data.c <br />
<md-tab>Syncs up the LiDAR data with the image file names. Stores it all into one csv.</md-tab>


