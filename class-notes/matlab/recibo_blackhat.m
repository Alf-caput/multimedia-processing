% ------------------------
% Script to detect receipt
% ------------------------

% Read the image
img = imread("images.jfif");

% 1. Find the receipt paper (return a mask)
% Convert to grayscale
img_gray = im2gray(img);

% Optional: Increase contrast of the image
% montage({img_gray, imadjust(img_gray)});
% img_gray = imadjust(img_gray);

% Smoothing for easier find the edges (white paper)
mask = fspecial("average", 3);
img_smooth = imfilter(img_gray, mask, "replicate");
montage({img_gray, img_smooth});

% Close the image to remove noise and letters of the receipt
img_close_gray = imclose(img_smooth, strel("disk", 10));
% montage({img_smooth, img_close_gray});

% % Binarize to get a white paper mask
% paper_mask = imbinarize(img_close_gray);
% montage({img_close_gray, paper_mask});
img_blackhat = img_close_gray - img_gray;
% montage({img_close_gray, img_blackhat});


img_bw = img_blackhat > 64;
montage({img_blackhat, img_bw});

% Point out lines
brush = strel("rectangle", [1, 10]);
% Dilate to remove spaces between letters
img_receipt_dilate = imdilate(img_bw, brush);
montage({img_bw, img_receipt_dilate});
% Refine boundaries
% img_receipt_close = imerode(img_receipt_dilate, brush);
% montage({img_receipt_dilate, img_receipt_close});

% img_open = imopen(img_bw, strel("rectangle", [1, 2]));
% montage({img_bw, img_open});
% 2. Remove background from the image

% Apply paper mask to the original image
% img_receipt = img .* uint8(paper_mask);
% montage({img, img_receipt});

% Or directly to the gray image
img_receipt = img_gray .* uint8(paper_mask);
% montage({img_gray, img_receipt});

% 3. Extract text from the image

% Turn background to similar color as the paper
img_receipt(~paper_mask) = 255;
% montage({img_gray, img_receipt});
