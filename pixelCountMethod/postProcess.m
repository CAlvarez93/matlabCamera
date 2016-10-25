max_fudge = 500;
pixel_buffer_true = max_fudge;
pixel_buffer_false = 50;
count = 1;
width = 0;
width_position = 0;
[y,x] = size(BWfinal);
% calculating width
for i=1:y
    for j=1:x
        
        if(BWfinal(i,j)==1)
            
            if(pixel_buffer_true == 0)
                 count = count + 1;
                 pixel_buffer_false = max_fudge;
            else
              pixel_buffer_true = pixel_buffer_true - 1;  
            end
        end
        
        if(BWfinal(i,j) == 0)
            if(pixel_buffer_false == 0)
                if(pixel_buffer_true == 0)
                    width = [width,count+max_fudge];
                    width_position = [width_position, i];
                    count = 0;
                    pixel_buffer_true = max_fudge;
                end
            else
                pixel_buffer_false = pixel_buffer_false - 1;
            end
            
        end
        
    end
end