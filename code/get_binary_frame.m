% Get the binary frame where only the animal is bright. Use regionprops to
% get the animal.
%
% Yixuan Li, 2023-12-20
%

function [binary_frame,animals_screened,RGB_frame] = get_binary_frame(video,mask_of_background)

% read a RGB frame
RGB_frame = readFrame(video);

% rgb to gray to binary
binary_frame = rgb_2_binary(RGB_frame);

% exclude boundaries
binary_frame(mask_of_background) = 0;

% exclude non-animal 1 pixels
animals = regionprops(binary_frame, 'Area', 'BoundingBox', 'Centroid');
animals_screened = screen_by_box(animals);
mask_of_screened_bounding_box = get_screened_mask(animals_screened,video.Width,video.Height);
binary_frame(~mask_of_screened_bounding_box) = 0;

end