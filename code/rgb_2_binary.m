function binary_frame = rgb_2_binary(rgb_frame)
gray_frame = rgb2gray(rgb_frame);
sensitivity_threshold = 0.01;
binary_frame = imbinarize(gray_frame, 'adaptive', 'Sensitivity', sensitivity_threshold);
end