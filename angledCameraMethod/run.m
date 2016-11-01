clc
clear all
close all

dirname = 'test_images/';
fname = '.JPG';

label = sprintf('obj height,pixel height,skew factor,distance');
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
  
  % print object height
  print_out = sprintf('%d, %d, %d, %d',obj_height,h,skew_factor,distance);
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
  
  % print object height
  print_out = sprintf('%d, %d, %d, %d',obj_height,h,skew_factor,distance);
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
  
  % print object height
  print_out = sprintf('%d, %d, %d, %d',obj_height,h,skew_factor,distance);
%   print_out = sprintf('%d',h);
  disp(print_out);
end