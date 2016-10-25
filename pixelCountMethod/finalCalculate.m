max = abs(major_points_width_position(1) - major_points_width_position(2));
height_start=1;
height_end=2;
for i=2:length(major_points_width_position)-1
    temp = abs(major_points_width_position(i) - major_points_width_position(i+1));
    if( temp > max)
        max = temp;
        height_start = major_points_width_position(i) - 1;
        height_end = major_points_width_position(i+1) - 1;
    end
end
object_height = width_position(height_end) - width_position(height_start)

max = abs(major_points_width(1) - major_points_width(2));
width_start = 1;
width_end = 2;
for i=2:length(major_points_width)-1
    temp = abs(major_points_width(i) - major_points_width(i+1));
    if(temp > max)
        max = temp;
        width_start = major_points_width(i);
        width_end = major_points_width(i+1);
    end
end
object_width = mean(width(width_start : width_end))