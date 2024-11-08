% Specify the zip file
zipFileName = 'DiceDataset.zip';

% If the dataset doesn't exist, unzip it
if ~exist('DiceDataset', 'dir')
    % Extract the contents
    unzip(zipFileName);
end

% Load the image
img = imread('DiceDataset/5/00100.bmp');

bw = imbinarize(img, 'adaptive');
bw = bwareaopen(bw, 50);
bw = imopen(bw, strel('disk', 3));
zeroDice = imclose(bw, strel('disk', 8));

% Mask the original image with the binarized image
maskedImg = img .* cast(zeroDice, 'like', img);
% maskedImg(~repmat(bw, [1, 1, 3])) = 0;
binDice = imbinarize(maskedImg, "adaptive");
% Display the masked image
imshow(binDice);
disp(nnz(bw) / nnz(binDice))
% imshow(zeroDice)
