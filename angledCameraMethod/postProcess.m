% postProcess
%   Takes the output of testingEdgeDetect and processes it.
%   Finds the pixel count from the center of the image to the top of the 
%   object in the image based on the height of the camera, the angle of 
%   the image and skew.
%   Assigns a skew value based on the image angle, which will be used to
%   multiply the height processed later.

distance = Globals('distance');         % distance from object (supplied by LiDAR)
cam_height = Globals('camera_height');  % height of the camera
cam_angle = Globals('camera_angle');    % angle of the camera from horizontal to ground
height_skew_factor = Globals('height_skew_factor');  % pixel to inch skew factor

[py,px] = size(BWfinal);               % size of the image in pixels
midX = px/2;
midY = py/2;

print_pixel_counts = sprintf('px: %d\npy: %d\nmidX: %d\nmidY: %d',px,py,midX,midY);
disp(print_pixel_counts);

max_fudge = 500;
pixel_buffer_true = max_fudge;
pixel_buffer_false = max_fudge;
count = 1;
height = 0;

% find the top of the object if it is above the center line

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

out = sprintf('x: %d\ny: %d', highest_x, highest_y);
disp(out);


height = abs(highest_y - midY);



% for j=600:2000
%     
%     for i=midY:-1:1   
%         if (i==midY)
%             temp = sprintf('x: %d\ty: %d\theight: %d',j, i, height);
%             disp(temp);
%         end
%         if(BWfinal(i,j)==1)
%             if(pixel_buffer_true == 0)
%                  count = count + 1;
%                  pixel_buffer_false = max_fudge;
%             else
%               pixel_buffer_true = pixel_buffer_true - 1;  
%             end
%         end
%         
%         if(BWfinal(i,j) == 0)
%             if(pixel_buffer_false == 0)
%                 if(pixel_buffer_true == 0)
%                     %height = [height,count+max_fudge];
%                     if (count+max_fudge > midY)
%                         height = midY;
%                     else
%                         height = count+max_fudge;
%                     end
%                     
%                     count = 0;
%                     pixel_buffer_true = max_fudge;
%                 end
%             else
%                 pixel_buffer_false = pixel_buffer_false - 1;
%             end
%             
%         end
%         
%     end
% end



% pole_angle = 0; % Angle of the pole. used to find where the matching
                  % camera height is in the picture

% function: find center of image.
%               image should be centered on the point relative to the point
%               matching the camera height, minus the angle height. 
%                   parameters:
%                       pole_angle
%                       cam_height

% function: determine skew of object height.
%               determine how skewed the image is based on the pole_angle_y
%                   parameters:
%                       pole_angle_y

% function: determine skew of object width.
%               determine how skewed the image is based on the pole_angle_x
%                   parameters:
%                       pole_angle_x


% calculating height
% for i=1:py
%     for j=1:px
%         
%         if(BWfinal(j,i)==1)
%             
%             if(pixel_buffer_true == 0)
%                  count = count + 1;
%                  pixel_buffer_false = max_fudge;
%             else
%               pixel_buffer_true = pixel_buffer_true - 1;  
%             end
%         end
%         
%         if(BWfinal(j,i) == 0)
%             if(pixel_buffer_false == 0)
%                 if(pixel_buffer_true == 0)
%                     height = [height,count+max_fudge];
%                     count = 0;
%                     pixel_buffer_true = max_fudge;
%                 end
%             else
%                 pixel_buffer_false = pixel_buffer_false - 1;
%             end
%             
%         end
%         
%     end
% end



