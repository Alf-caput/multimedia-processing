% Specify the zip file
zipFileName = 'DiceDataset.zip';

% If the dataset doesn't exist, unzip it
if ~exist('DiceDataset', 'dir')
    % Extract the contents
    unzip(zipFileName);
end

% Load the image
img = imread('DiceDataset/1/00000.bmp');
imshow(img)

disp(size(img))
% Show the dimensions of the image
[numRows, numCols, numColorChannels] = size(img);
fprintf('Image size is %d rows x %d columns x %d color channels.\n', numRows, numCols, numColorChannels);
if numColorChannels == 1
    fprintf('The image is a single channel image (a grayscale image).\n');
end
