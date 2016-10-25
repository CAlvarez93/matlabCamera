clc
clear all
close all
load('goproParams.mat');
% read in image, turn black and white, edge detect,
% give array of true, false of object
rawImage = 'GOPR0164.JPG';

I = imread(rawImage,'jpg');
I = undistortImage(I,cameraParams);
figure, imshow(I), title('original image');

% Use filterColors to isolate the green value in an image.
% This is overwrite the I calculated before.
% filterColors 

testingEdgeDetect;

% calculate pixel x-axis pixel count for every y-axis pixel
% of the object
postProcess;
% figure;
% subplot(2,1,1);scatter(1:length(width),width);title('width');
% subplot(2,1,2);scatter(1:length(width_position),width_position);title('width position (height)');


% give the average width of each major x-axis width
% findMajorValues;
% figure;scatter(1:length(totalAverages),totalAverages);title('totalAverages');

% edge finder script
edgeFinder;
% figure;
% subplot(2,1,1);
% scatter(1:length(major_points_width),major_points_width);
% title('major points width');
% subplot(2,1,2);
% scatter(1:length(major_points_width_position),major_points_width_position);
% title('major points width position');

% This will provide the object_height and object_width of the object in
% pixels
finalCalculate;

decision = input('Is this a height measurement (1) or a width measurement (2): ');
value = input('What is the measurement value?: ');
if(decision == 1)
    calculated_width = (value / object_height ) * object_width
    value = input('What is the actually width measurement?: ');
    percent_error = (abs(value - calculated_width) / value) * 100
else
    calculated_height = (value / object_width ) * object_height
    value = input('What is the actually height measurement?: ');
    percent_error = (abs(value - calculated_height) / value) * 100
end
