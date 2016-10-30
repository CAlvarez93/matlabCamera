% height of the picture / not taking into account the camera angle or skew
% due to pole angle

skew_factor = heightSkewFactor('quadratic', height);  % pixel to inch skew factor

%[h, indx] = max(height);
h = height;
d = sprintf('pixel height: %d', h);
%disp(d);

%imshow(Segout);
%line([indx,indx],[0,py]);

% Temporary! not best method describe below

% function: multiply height by skew values
%                   parameters:
%                       pole_angle
%                       cam_height

% function: find height from pythagorean theorem
%                   parameters:
%                       pole_angle
%                       cam_height
%                       cam_angle
%                       distance



a = (sin(90-cam_angle)*(distance))/sin(cam_angle);
a_print = sprintf('preprocess height: %d',cam_height - a);
%disp(a_print);

unskewed_h = h*skew_factor;
unskewed_h_print = sprintf('unskewed_h: %d', unskewed_h);
%disp(unskewed_h_print);

obj_height = cam_height - (a - unskewed_h);
d = sprintf('obj_height: %d',obj_height);
%disp(d);

%test_height = cam_height - (distance/tan(pole_angle));
%disp('obj_height', obj_height);

% Print globals
globals_print = sprintf('distance: %d\ncam_height: %d\ncam_angle: %d\nskew_factor: %d', distance, cam_height, cam_angle, skew_factor);
%disp(globals_print);

print_out = sprintf('%d, %d, %d, %d',obj_height,skew_factor,distance, a);
disp(print_out);

