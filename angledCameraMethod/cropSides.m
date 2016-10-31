%% Set the left and right fourths out of the image to false
[size_y, size_x] = size(BWoutline);

% crop the sides out of the image in binary format
for i=1:size_y
    for j=1:size_x/4
        BWoutline(i,j) = 0;
    end
    for j=3*size_x/4:size_x
        BWoutline(i,j) = 0;
    end
end

%figure, imshow(BWoutline), title('perimetered - cropped');