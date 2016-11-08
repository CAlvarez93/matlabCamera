clc
clear all
close all

dirname = 'test_images/';
fname = '.JPG';

label = sprintf('Actual Height, Calculated Height, Pixel Height, Actual Skew Factor, Calculated Skew Factor, Percent Error, Distance');
%label = sprintf('pixel height');
disp(label);

arr = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30];
for arg=1:30
    
  % file
  argv = int2str(arg);
  temp = strcat(dirname, argv);
  image_filename = strcat(temp,fname);
  
  % distance
  input_dist = arr(arg);
   
  mainScript
  
  % run error checking
  [sf, pe ] = sfCheck(h, 37.5, a, cam_height, skew_factor);
  
  % print object height
  print_out = sprintf('%d, %d, %d, %d, %d, %d, %d', 37.5, obj_height, h, sf, skew_factor, pe, distance);
%   print_out = sprintf('%d',h);
  disp(print_out);
end

for arg=31:60
      
  % file
  argv = int2str(arg);
  temp = strcat(dirname, argv);
  image_filename = strcat(temp,fname);
  
  % distance
  input_dist = arr(arg-30);
  
  mainScript
  
  % run error checking
  [sf, pe ] = sfCheck(h, 25.75, a, cam_height, skew_factor);
  
  % print object height
  print_out = sprintf('%d, %d, %d, %d, %d, %d, %d', 37.5, obj_height, h, sf, skew_factor, pe, distance);
%   print_out = sprintf('%d',h);
  disp(print_out);
end

for arg=61:90
      
  % file
  argv = int2str(arg);
  temp = strcat(dirname, argv);
  image_filename = strcat(temp,fname);
  
  % distance
  input_dist = arr(arg-60);
  
  mainScript
  
  % run error checking
  [sf, pe ] = sfCheck(h, 42.25, a, cam_height, skew_factor);
  
  % print object height
  print_out = sprintf('%d, %d, %d, %d, %d, %d, %d', 37.5, obj_height, h, sf, skew_factor, pe, distance);
%   print_out = sprintf('%d',h);
  disp(print_out);
end