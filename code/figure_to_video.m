% from .jpg to .mp4
%
% Yixuan Li, 2023-12-20
%

function figure_to_video(folder_name,save_folder_path)

% get all images 
image_files = dir(fullfile(folder_name,'*.jpg'));
image_files_names = {image_files.name}';

% sort
[~,index] = sort(cellfun(@(x) str2double(regexprep(x, '\D', '')), image_files_names));
sorted_image_files = image_files_names(index);

% cut
start_frame = 24; % drop the images when putting the animal in
end_frame = size(sorted_image_files,1);
sorted_image_files = sorted_image_files(start_frame:end_frame);

% create save video
[~,save_file_name] = fileparts(folder_name);
save_full_path = fullfile(save_folder_path,save_file_name);
if ~isfolder(save_folder_path)
    mkdir(save_folder_path);
end
video = VideoWriter(save_full_path,'MPEG-4');
video.FrameRate = 30;

% write
open(video);
write_into_video(sorted_image_files, video, folder_name);
close(video);

end