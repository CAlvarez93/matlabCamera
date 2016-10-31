%%
I = rgb2gray(I);
[~, threshold] = edge(I,'sobel');
fudgeFactor = .5;
BWs = edge(I,'sobel',threshold * fudgeFactor);
%figure, imshow(BWs), title('binary gradient mask');

se90 = strel('line', 3, 90);
se0 = strel('line', 3, 0);
BWsdil = imdilate(BWs, [se90 se0]);
%figure, imshow(BWsdil), title('dilated gradient mask');

BWdfill = imfill(BWsdil, 'holes');
%figure, imshow(BWdfill), title('binary image with filled holes');

%% took this out because if the primary object is too slim, it will
%  be removed entirely
%BWnobord = imclearborder(BWdfill, 4);
%figure, imshow(BWnobord), title('cleared border image');

%% 
%seD = strel('diamond',10);
seD = strel('diamond',6);
BWfinal = imerode(BWdfill,seD);
%BWfinal = imerode(BWnobord,seD);
%BWfinal = imerode(BWfinal,seD);
%figure, imshow(BWfinal), title('segmented image');

BWoutline = bwperim(BWfinal, 4);
%figure, imshow(BWoutline), title('perimetered');

Segout = I;
Segout(BWoutline) = 255;
%figure, imshow(Segout), title('outlined original image');
