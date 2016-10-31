%% Comment out for batch testing
% clc
% clear all
% close all
% 
% dirname = 'test_images/';
% image = '5.JPG';
% image_filename = strcat(dirname, image);


%% Comment out when running normally
dirname = 'test_images/';
fname = '.JPG';
argv = int2str(arg);
temp = strcat(dirname, argv);
image_filename = strcat(temp,fname);

%% Define input variables
%distance = Globals('distance');         % distance from object (supplied by LiDAR)
distance = input_dist;
cam_height = Globals('camera_height');  % height of the camera
cam_angle = Globals('camera_angle');    % angle of the camera from horizontal to ground

%% read in image
%
% load parameters of our camera
load('goproParams.mat');

I = imread(image_filename,'jpg');
I = undistortImage(I,cameraParams); % 'unfish-eye' the image
%figure, imshow(I), title('original image');

%% filter colors
%    mask green as black
%    mask red/blue/gray as white
filterColors;

%% read in image, turn black and white, edge detect,
%  give array of true, false of object
testingEdgeDetect;

%% 'Crop' the sides out of the image
cropSides;

%% calculate y-axis pixel count for the tallest column
findPixelHeight;

%% give the average width of each major x-axis width
calcObjectHeight;