% The purpose of the script is to use a linear approximation and compare
% the slope from point to point and take note of extreme slope changes as
% we go through both width and width_position. I will then measure the
% distance between extreme slope changes and store the value - hopefully
% this will yield the height and width of the object and also detecting
% major curvatures in the desired object.

% first we will go through the array "width"
prev_slope = abs(width(2)-width(1));
major_points_width=1;
for i=3:length(width)
    slope = abs(width(i) - width(i-1));
    if(abs(prev_slope - slope) > 20)
        major_points_width = [major_points_width i];
    end
    prev_slope = slope;
end

% now we will find the major points for "width_position"
prev_slope = abs(width_position(2)-width_position(1));
major_points_width_position=1;
for i = 3:length(width_position)
    slope = abs(width_position(i-1) - width_position(i));
%     if((slope == 1 && prev_slope ~= 1) || (prev_slope == 1 && slope ~= 1))
%     if(prev_slope ~= slope)
    if(abs(prev_slope - slope) > 5)
        major_points_width_position = [major_points_width_position i];
    end
    prev_slope = slope;
end
major_points_width_position = [major_points_width_position length(width_position)];