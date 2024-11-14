
clf, clc;
dices = {};
for i = 1:6
    file_path = sprintf("DiceDataset/%d/00399.bmp", i);
    img = imread(file_path);    
    dice = edge(img, 'sobel');
    [centers, radii] = imfindcircles(dice, [6 11], 'Sensitivity', 0.91);

    clf;
    imshow(img); 
    hold on;
    
    % Dibujar los círculos detectados
    viscircles(centers, radii, 'Color', 'r', 'LineWidth', 2);
    hold off
    % Capturar la imagen con los círculos
    frame = getframe(gca);
    dice = frame.cdata;
    close; % Cerrar la figura
    dices{i} = dice;
end
montage(dices)
viscircles(centers, radii);
% dices = {};
% for i = 1:6
%     file_path = sprintf("DiceDataset/%d/00399.bmp", i);
%     img = imread(file_path);    
%     dice = imfilter(img, fspecial('average', 4), 'replicate'); % 4
%     dice = imclose(dice, strel('disk', 10)); % disk 10
%     dice = imadjust(dice);
%     dice = dice - img;
%     dice = dice > 128;
%     % dice = edge(dice, 'sobel');
%     [centers, radii] = imfindcircles(dice, [6 12], 'Sensitivity', 0.95);

%     clf;
%     imshow(img); 
%     hold on;
    
%     % Dibujar los círculos detectados
%     viscircles(centers, radii, 'Color', 'r', 'LineWidth', 2);
%     hold off
%     % Capturar la imagen con los círculos
%     frame = getframe(gca);
%     dice = frame.cdata;
%     close; % Cerrar la figura
%     dices{i} = dice;
% end
% montage(dices)
% viscircles(centers, radii);
