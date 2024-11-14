function [pips, centers, radii] = count_pips(dice_img)
    dice_img_sobel = edge(dice_img, 'sobel');
    [centers, radii] = imfindcircles(dice_img_sobel, [6 12], 'Sensitivity', 0.91);
    pips = numel(radii);
    if pips == 0
        pips = 1;
    end
    if pips > 6
        pips = 6;
    end
end

