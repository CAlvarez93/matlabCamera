function [ output_args ] = Globals( input_args )
%GLOBALS retrieves global variables
    
    if (strcmp(input_args,'camera_height'))
        output_args = camera_height();
    elseif (strcmp(input_args,'camera_angle'))  
        output_args = camera_angle();
    elseif (strcmp(input_args,'distance'))  
        output_args = distance();
    elseif (strcmp(input_args,'height_skew_factor'))  
        output_args = height_skew_factor();
    end
    
end

%% camera_height
%Retrieves the camera height
%   outputs the height of the camera
function [ output_args ] = camera_height()
    output_args = 63;
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
    output_args = 56;
end

%% height_skew_factor
%   outputs the average height
%   skew factor.
%   Obtained from many tests
function [ output_args ] = height_skew_factor()
    avg = (2.75/921) + 2.75/638;
    avg = avg/2;
    output_args = avg;
    %output_args = 2.75/921;
end