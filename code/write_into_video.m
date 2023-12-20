% loop to read each image and write it into a video
%
% Yixuan Li, 2023-12-20
%

function write_into_video(sorted_image_files, video, folder_name)

for i=1:length(sorted_image_files)
    img = imread(fullfile(folder_name,sorted_image_files{i}));
    writeVideo(video, img);
end

end