% RGB to grey to binary, using direct adapt.
%
% Yixuan Li, 2023-12-20
%

function binary_frame = rgb_2_binary(rgb_frame)
gray_frame = rgb2gray(rgb_frame);
sensitivity_threshold_for_animals = 0.01;
binary_frame = imbinarize(gray_frame, 'adaptive', 'Sensitivity', sensitivity_threshold_for_animals);
end