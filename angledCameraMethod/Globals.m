function [ output_args ] = Globals( input_args )
%GLOBALS retrieves global variables
    
    if (strcmp(input_args,'camera_height'))
        output_args = camera_height();
    elseif (strcmp(input_args,'camera_angle'))  
        output_args = camera_angle();
    elseif (strcmp(input_args,'distance'))  
        output_args = distance();
    end
end

%% camera_height
%Retrieves the camera height
%   outputs the height of the camera
function [ output_args ] = camera_height()
    output_args = 43.75;
end

%% camera_angle
%   outputs the angle of the
%   camera from horizontal
function [ output_args ] = camera_angle()
    output_args = 45;
end

%% distance
%   outputs the LiDAR distance
%   minus the difference
%   between the LiDAR and
%   Camera distances
function [ output_args ] = distance()
    % d - cd = output
    output_args = 5;
end