clc
clear all
close all

%% set these values
image = 'GOPR0281.JPG';
input_dist = 1;

%% don't touch
%
dirname = 'test_images/';
image_filename = strcat(dirname, image);

label = sprintf('obj height,pixel height,skew factor,distance');
%label = sprintf('pixel height');
disp(label);

mainScript

% print object height
%print_out = sprintf('%d, %d, %d, %d',obj_height,h,skew_factor,distance);
print_out = sprintf('%d',h);
disp(print_out);