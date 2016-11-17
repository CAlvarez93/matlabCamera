clc
clear all
close all

%% output file
oid = fopen('results.csv', 'wt');
formatspec = '%d, %d\n';
fprintf(oid, 'Height-Matlab, Width-LiDAR\n');

dirname = 'test_images/';

label = sprintf('Height-Matlab, Width-LiDAR');
%label = sprintf('pixel height');
disp(label);

%% LiDAR data
fid = fopen('lidar_data.csv');
C = textscan(fid, '%d %d %s', 'Delimiter', ',');
rows = size(C{1});

fclose(fid);

%% Run Analysis
for arg=1:rows
    
  % file
  fname = C{3}{arg};
  image_filename = strcat(dirname,fname);
  
  % distance
  input_width = C{2}(arg);
   
  mainScript2

  
  % print object height
  %print_out = sprintf(formatspec, calculated_height, input_width);
  %disp(print_out);

  fprintf(oid, formatspec, calculated_height, input_width);
end

fclose(oid);
quit;
