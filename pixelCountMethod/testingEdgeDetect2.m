% Pause is for the sake of presentations
%pause(5);
I = rgb2gray(I);
[~, threshold] = edge(I,'sobel');
fudgeFactor = 0.5;
BWs = edge(I,'sobel',threshold * fudgeFactor);
%figure, imshow(BWs), title('binary gradient mask');

% Pause is for the sake of presentations
%pause(5);
se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
%figure, imshow(BWsdil), title('dilated gradient mask');

% Pause is for the sake of presentations
%pause(5);
BWdfill = imfill(BWsdil, 'holes');
%figure, imshow(BWdfill),
%title('binary image with filled holes');

% Pause is for the sake of presentations
%pause(5);
BWnobord = imclearborder(BWdfill, 4);
%figure, imshow(BWnobord), title('cleared border image');

% Pause is for the sake of presentations
%pause(5);
seD = strel('diamond',10);   %Make anywhere from 5 - 10
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
%figure, imshow(BWfinal), title('segmented image');

% Pause is for the sake of presentations
%pause(5);
BWoutline = bwperim(BWfinal);
Segout = I;
Segout(BWoutline) = 255;
%figure, imshow(Segout), title('outlined original image');