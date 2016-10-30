%% Comment out for batch testing
%clc
%clear all
%close all

%image_filename = '5.JPG';

%% Comment out when running normally
fname = '.JPG';
argv = int2str(arg);
image_filename = strcat(argv,fname);


%% read in image
%
I = imread(image_filename,'jpg');
%figure, imshow(I), title('original image');

%% filter colors
%    mask green as black
%    mask red/blue/gray as white
filterColors;

%% read in image, turn black and white, edge detect,
% give array of true, false of object
testingEdgeDetect;

%% calculate y-axis pixel count for the tallest column
postProcess;

%% 
% give the average width of each major x-axis width
findMajorValues;
