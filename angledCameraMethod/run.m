clc
clear all
close all

% output file
oid = fopen('results.csv', 'wt');
formatspec = '%d, %d, %d, %d, %d, %d, %d, %d\n';
fprintf(oid, 'Actual Height, Calculated Height, A, Pixel Height, Actual Skew Factor, Calculated Skew Factor, Percent Error, Distance\n');

dirname = 'test_images/';

label = sprintf('Actual Height, Calculated Height, A, Pixel Height, Actual Skew Factor, Calculated Skew Factor, Percent Error, Distance');
%label = sprintf('pixel height');
disp(label);

object_height = [ 37.5 25.75 43.25 ];

fid = fopen('lidar_data.csv');
C = textscan(fid, '%d %d %s', 'Delimiter', ',');
rows = size(C{1});

fclose(fid);

for arg=1:rows
    
  % file
  fname = C{3}{arg};
  image_filename = strcat(dirname,fname);
  
  % distance
  input_dist = C{1}(arg);
   
  mainScript
  
  % run error checking
  [sf, pe ] = sfCheck(h, object_height(1), a, cam_height, skew_factor);
  
  % print object height
  print_out = sprintf('%d, %d, %d, %d, %d, %d, %d, %d', object_height(1), obj_height, a, h, sf, skew_factor, pe, input_dist);
%   print_out = sprintf('%d',h);
  %disp(print_out);

  fprintf(oid, formatspec, object_height(1), obj_height, a, h, sf, skew_factor, pe, input_dist);
end
fclose(oid);

