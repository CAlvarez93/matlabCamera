load('goproParams.mat');
% read in image, turn black and white, edge detect,
% give array of true, false of object
rawImage = image_filename;

I = imread(rawImage,'jpg');
I = undistortImage(I,cameraParams);
%figure, imshow(I), title('original image');

% Use filterColors to isolate the green value in an image.
% This is overwrite the I calculated before.
% filterColors 

testingEdgeDetect2;

% calculate pixel x-axis pixel count for every y-axis pixel
% of the object
postProcess;
% Pause is for the sake of presentations
%pause(5);
%figure;
%subplot(2,1,1);scatter(1:length(width),width);title('width');
%subplot(2,1,2);scatter(1:length(width_position),width_position);title('width position (height)');


% give the average width of each major x-axis width
% findMajorValues;
% figure;scatter(1:length(totalAverages),totalAverages);title('totalAverages');

argstr = int2str(arg);
outimg = strcat('test_images/', argstr);
plot1 = strcat(outimg, '_plot1');
plot2 = strcat(outimg, '_plot2');

% edge finder script
edgeFinder;
% Pause is for the sake of presentations
%pause(5);
figure;
subplot(2,1,1);
scatter(1:length(major_points_width),major_points_width);
print(plot1, '-dpng');

title('major points width');
subplot(2,1,2);
scatter(1:length(major_points_width_position),major_points_width_position);
title('major points width position');
print(plot2, '-dpng');

% This will provide the object_height and object_width of the object in
% pixels
finalCalculate;

%% final calculations

value=input_width;
%% Width measurement
%calculated_width = (value / object_height ) * object_width
%value = input('What is the actually width measurement?: ');
%percent_error = (abs(value - calculated_width) / value) * 100

%% Height Measurement
calculated_height = (value / object_width ) * object_height
%percent_error = (abs(value - calculated_height) / value) * 100

