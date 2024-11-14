% Specify the zip file
zipFileName = 'DiceDataset.zip';

% If the dataset doesn't exist, unzip it
if ~exist('DiceDataset', 'dir')
    % Extract the contents
    unzip(zipFileName);
end

total_images = 2400;
true_labels = zeros(total_images, 1);
predicted_labels = zeros(total_images, 1);
base_dir = "DiceDataset";

i = 1;
for true_pip_count = 1: 6
    % Create the directory path for the current pip count
    dir_path = fullfile(base_dir, num2str(true_pip_count));
    % Get a list of all images in the directory
    image_files = dir(fullfile(dir_path, '*.bmp'));
    disp("Processing directory " + dir_path);
    for k = 1:length(image_files)
        % Get the full path to the image file
        file_path = fullfile(image_files(k).folder, image_files(k).name);
        % Read the image
        img = imread(file_path);
        % Predict the pip count using the user-defined function
        n = count_pips(img);
        % Assign true and predicted labels to the preallocated arrays    
        true_labels(i) = true_pip_count;
        predicted_labels(i) = n;
        i = i + 1;
    end
end

% Create the confusion matrix
confusion_matrix = confusionmat(true_labels, predicted_labels);

% Display the confusion matrix
disp('Confusion Matrix:');
disp(confusion_matrix);

figure;
confusionchart(confusion_matrix);
title('Confusion Matrix for Dice Pip Count Prediction');

% Extract the diagonal (correct predictions)
correct_predictions = trace(confusion_matrix); % Sum of diagonal elements
% Calculate the total number of predictions
total_predictions = sum(confusion_matrix(:)); % Sum of all elements in the matrix
accuracy = correct_predictions / total_predictions;
fprintf("Accuracy: %.2f%%\n", accuracy * 100);
