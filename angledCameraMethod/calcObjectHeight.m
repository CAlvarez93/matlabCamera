%% calcObjectHeight
%    Given the difference in height (in pixels) from the center of the
%    image, this script will use the camera height, camera angle, and 
%    distance from the object to calculate the height of the object.

%% Define variables

% pixel to inch skew factor
skew_factor = heightSkewFactor(input_dist, height);  
h = height; % pixel height

%d = sprintf('pixel height: %d', h);
%disp(d);

%% Calculate height

% calculate height difference between camera and center of the image
a = (sin(90-cam_angle)*(distance))/sin(cam_angle);
a_print = sprintf('preprocess height: %d',cam_height - a);
%disp(a_print);

% calculate actual height of pixels
unskewed_h = h*skew_factor;
unskewed_h_print = sprintf('unskewed_h: %d', unskewed_h);
%disp(unskewed_h_print);

% calculate object height
obj_height = cam_height - (a - unskewed_h);
d = sprintf('obj_height: %d',obj_height);
%disp(d);

%% Display results

% print input variables
globals_print = sprintf('distance: %d\ncam_height: %d\ncam_angle: %d\nskew_factor: %d', distance, cam_height, cam_angle, skew_factor);
%disp(globals_print);

% % print object height
% print_out = sprintf('%d, %d, %d, %d',obj_height,skew_factor,distance, a);
% disp(print_out);