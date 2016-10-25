clc
clear all
close all

%findTest;

image_filename = '5.JPG';
%% read in image
%
I = imread(image_filename,'jpg');
figure, imshow(I), title('original image');

%% filter colors
%    mask green as black
%    mask red/blue/gray as white
filterColors;

%% read in image, turn black and white, edge detect,
% give array of true, false of object
testingEdgeDetect;

%% calculate y-axis pixel count for the tallest column
%postProcess;

%% 
% give the average width of each major x-axis width
%findMajorValues;
