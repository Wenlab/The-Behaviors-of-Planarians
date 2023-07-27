clc;clear;close all;

% read
folder_name = 'F:\1_learning\research\planarian\data\20230716 preliminary';
file_name = '20230716_2315.avi';
full_path = fullfile(folder_name,file_name);
video = VideoReader(full_path);
initial_time = video.currentTime; % When you change the current time, you can use this to get back to the start.

% save
outputVideoFile = strrep(full_path,'.','_binarized_v2.');
outputVideo = VideoWriter(outputVideoFile, 'Grayscale AVI');
open(outputVideo);

% exclude boundaries
sensitivity_threshold = 0.01;
exclusionMask = createExclusionMask(video,sensitivity_threshold);
figure;
imshow(exclusionMask);

% video properties
videoWidth = video.Width;
videoHeight = video.Height;
N_Frames = video.NumFrames;

% centroid distance threshold
distance_threshold = 50;  % Set this according to your specific video

% loop
video.currentTime = initial_time;
count = 0;
centroids = {};
while hasFrame(video)
    count = count + 1;
    frame = readFrame(video);
    grayFrame = rgb2gray(frame);
    threshold = graythresh(grayFrame);
    binaryFrame = imbinarize(grayFrame, 'adaptive', 'Sensitivity', sensitivity_threshold);
    binaryFrame(exclusionMask) = 0;

    bounding_box = regionprops(binaryFrame, 'Area', 'BoundingBox');
    bounding_box_screened = screen_by_box(bounding_box);
    mask_of_screened_bounding_box = get_screened_mast(bounding_box_screened,videoWidth,videoHeight);
    binaryFrame(~mask_of_screened_bounding_box) = 0;
    imshow(binaryFrame);

    binaryFrameUint8 = uint8(binaryFrame * 255);
    writeVideo(outputVideo, binaryFrameUint8);
end
close(outputVideo);
close all;