clc;clear;close all;

% get all images
folder_name = 'F:\1_learning\research\planarian\data\20230728 test boundary\20230728_2027';
image_files = dir(fullfile(folder_name,'*.jpg'));
image_files_names = {image_files.name}';

% sort
[~,index] = sort(cellfun(@(x) str2double(regexprep(x, '\D', '')), image_files_names));
sorted_image_files = image_files_names(index);

% create save video
[~,save_file_name] = fileparts(folder_name);
video = VideoWriter([save_file_name '.avi']);
video.FrameRate = 2;

% write
open(video);
write_into_video(sorted_image_files, video, folder_name);
close(video);

function write_into_video(sorted_image_files, video, folder_name)
% loop to read each image and write it into a video
for i=1:length(sorted_image_files)
    img = imread(fullfile(folder_name,sorted_image_files{i}));
    writeVideo(video, img);
end
end