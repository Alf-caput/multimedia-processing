% Specify the zip file
zipFileName = 'DiceDataset.zip';

% If the dataset doesn't exist, unzip it
if ~exist('DiceDataset', 'dir')
    % Extract the contents
    unzip(zipFileName);
end

dices = {};
for i = 1:6
    file_path = sprintf("DiceDataset/%d/00100.bmp", i);
    img = imread(file_path);    
    dice = process_dice(img);
    dices{i} = dice;
end


montage(dices);
% Assuming `binaryImage` is your binarized image with white regions on black background
% Step 1: Label the components
% [labeledImage, numRegions] = bwlabel(img_bw);

% Step 2: Measure properties
% props = regionprops(labeledImage, 'Extrema', 'Area');

% Initialize variables to find the squarest region
% minAspectRatioDiff = inf;
% squarestRegionIndex = 0;

% Step 3: Loop through each region and calculate the "squareness"
% for k = 1:numRegions
%     boundingBox = props(k).BoundingBox;
%     width = boundingBox(3);
%     width = norm(corners(1,:) - corners(3,:));
%     height = norm(corners(5,:) - corners(7,:));
%     height = boundingBox(4);
    
%     Calculate the aspect ratio
%     aspectRatio = width / height;
%     aspectRatioDiff = abs(aspectRatio - 1); % Closer to 0 means more square-like
    
%     Check if this is the most square-like region so far
%     if aspectRatioDiff < minAspectRatioDiff
%         minAspectRatioDiff = aspectRatioDiff;
%         squarestRegionIndex = k;
%     end
% end

% Step 4: Create a new binary image with only the squarest region
% squarestRegionImage = ismember(labeledImage, squarestRegionIndex);

% Display the result
% imshow(squarestRegionImage);
% montage({squarestRegionImage, img})
% title('Squarest White Element');
