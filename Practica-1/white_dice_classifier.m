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

for i = 1:length(dices)
    dice = dices{i};
    [pips, centers, radii] = count_pips(dice);
    fprintf("Pips: %d\n", pips);
end
