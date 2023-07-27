function [binary_frame,properties_screened] = get_binary_frame(video,mask_of_background)

% read a RGB frame
RGB_frame = readFrame(video);

% rgb to gray to binary
binary_frame = rgb_2_binary(RGB_frame);

% exclude boundaries
binary_frame(mask_of_background) = 0;

% exclude non-animal 1 pixels
properties = regionprops(binary_frame, 'Area', 'BoundingBox', 'Centroid');
properties_screened = screen_by_box(properties);
mask_of_screened_bounding_box = get_screened_mask(properties_screened,video.Width,video.Height);
binary_frame(~mask_of_screened_bounding_box) = 0;

end