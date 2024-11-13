function dice_img = process_dice(img)
    img_smooth = imfilter(img, fspecial('average', 4), 'replicate'); % 4
    img_close = imclose(img_smooth, strel('disk', 10)); % disk 10
    img_close = imadjust(img_close);
    img_blackhat = img_close - img;
    dice_img = img_blackhat > 128;
end
