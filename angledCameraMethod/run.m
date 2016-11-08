clc
clear all
close all

dirname = 'test_images/';
fname = '.JPG';

label = sprintf('Actual Height, Calculated Height, A, Pixel Height, Actual Skew Factor, Calculated Skew Factor, Percent Error, Distance');
%label = sprintf('pixel height');
disp(label);

object_height = [ 25.75 42.25 ];

% arr = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
arr = [16 18 20 22 24 26 28 30];

for arg=1:8
    
  % file
  argv = int2str(arg);
  temp = strcat(dirname, argv);
  image_filename = strcat(temp,fname);
  
  % distance
  input_dist = arr(arg);
   
  mainScript
  
  % run error checking
  [sf, pe ] = sfCheck(h, object_height(1), a, cam_height, skew_factor);
  
  % print object height
  print_out = sprintf('%d, %d, %d, %d, %d, %d, %d, %d', object_height(1), obj_height, a, h, sf, skew_factor, pe, input_dist);
%   print_out = sprintf('%d',h);
  disp(print_out);
end