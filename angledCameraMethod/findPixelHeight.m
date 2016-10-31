%% findPixelHeight
%   Takes the output of testingEdgeDetect and processes it.
%   Finds the pixel count from the center of the image to the top of the 
%   object in the image based on the height of the camera, the angle of 
%   the image and skew.
%
%   Assigns a skew value based on the image angle, which will be used to
%   multiply the height processed later.

%% Define central coordinates
[py,px] = size(BWfinal);               % size of the image in pixels
midX = px/2;
midY = py/2;

% display dimensions
%print_pixel_counts = sprintf('px: %d\npy: %d\nmidX: %d\nmidY: %d',px,py,midX,midY);
%disp(print_pixel_counts);

%% find the top of the object
highest_y = py;
highest_x = 1;
for i=1:py
    for j=1:px
        if (BWoutline(i,j) == 1)
            if (highest_y > i)
                highest_y = i;
                highest_x = j;
            end
        end
    end 
end

% display the coordinates of the top of the object
%out = sprintf('x: %d\ny: %d', highest_x, highest_y);
%disp(out);

% top of the object (y-coordinate)
height = midY - highest_y;
%out = sprintf('%d',height);
%disp(out);