goproImages={'GOPR0079.JPG','GOPR0080.JPG','GOPR0081.JPG','GOPR0082.JPG','GOPR0083.JPG','GOPR0084.JPG','GOPR0085.JPG'};
image = fullfile(matlabroot, 'toolbox', 'vision','visiondata', 'calibration', 'fishEye', goproImages);
images = imageSet(image);
[imagePoints, boardSize] = detectCheckerboardPoints(images.ImageLocation);
squareSize = 27;
worldPoints = generateCheckerboardPoints(boardSize,squareSize);
cameraParams = estimateCameraParameters(imagePoints,worldPoints);