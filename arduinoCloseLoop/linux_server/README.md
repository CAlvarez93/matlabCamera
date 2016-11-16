This directory contains the code the run a loop on a UNIX machine to accept data from RADA and a GoPro. It will run this data through the height measurement matlab scripts, and then archive the results in the respective folders.

Script breakdown:

run:
	Master script. Will run the whole process for you.

post.c:
	Listens for the post data sent from RADA. Contains the LiDAR information.

get_pic.cpp:
	Downloads all of the images from the GoPro into the current directory.

sync_data.c
	Syncs up the LiDAR data with the image file names. Stores it all into one csv.


