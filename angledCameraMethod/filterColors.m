%% convert all non green pixels to white and all green pixels to black
r = I(:,:,1); %is the red component
g = I(:,:,2); %is the green component
b = I(:,:,3); %is the blue component

x = r;
y = g;
z = b;

%% color masks
white      = 255;
black      = 0;
base_green = 65;
base_red   = 65;
base_blue  = 65;
base_diff  = 10;

%% Create color filters
r_plain = find(r > base_red & ~(g-r >= base_diff));
b_plain = find(b > base_blue & ~(g-b >= base_diff));
g_plain = find(g > base_green | (g-b >= base_diff) | (g-r >= base_diff));
black_plain = find((g <= base_green & b <= base_blue & r <= base_red) & (~(g-b >= base_diff) | ~(g-r >= base_diff)) );
%gray_plain = find((abs(r-g) <= 15) & (abs(r-b) <= 3) & (abs(b-g) <= 3));
%g_plain = find((g-r > 5) & (g-b > 5));

%% Apply color masks to filtered pixels
[r, g, b] = applyColorFilters(r, g, b, g_plain, black);
[r, g, b] = applyColorFilters(r, g, b, black_plain, white);
%[r, g, b] = applyColorFilters(r, g, b, gray_plain, white);
[r, g, b] = applyColorFilters(r, g, b, r_plain, white);
[r, g, b] = applyColorFilters(r, g, b, b_plain, white);

%% display results
I = cat(3,r,g,b);
figure, imshow(I), title('colors stripped');