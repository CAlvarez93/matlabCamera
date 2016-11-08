clc
clear all
close all

%% set these values
image = '1.JPG';
input_dist = 1;
actual_obj_height = 37.5;

%% don't touch
%
dirname = 'test_images/';
image_filename = strcat(dirname, image);

label = sprintf('Actual Height, Calculated Height, A, Pixel Height, Actual Skew Factor, Calculated Skew Factor, Percent Error, Distance');
%label = sprintf('pixel height');
disp(label);

mainScript

% run error checking
  [sf, pe ] = sfCheck(h, 37.5, a, cam_height, skew_factor);
  
  % print object height
  print_out = sprintf('%d, %d, %d, %d, %d, %d, %d, %d', actual_obj_height, obj_height, a, h, sf, skew_factor, pe, distance);
%print_out = sprintf('%d',h);
disp(print_out);