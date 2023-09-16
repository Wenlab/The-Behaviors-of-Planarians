function figure_to_video(folder_name,save_folder_path)

% get all images 
% folder_name = 'D:\Public_repository\planarian\data\20230808_1843';
image_files = dir(fullfile(folder_name,'*.jpg'));
image_files_names = {image_files.name}';

% sorte
[~,index] = sort(cellfun(@(x) str2double(regexprep(x, '\D', '')), image_files_names));
sorted_image_files = image_files_names(index);

% cut
start_frame = 24;
end_frame = size(sorted_image_files,1);
sorted_image_files = sorted_image_files(start_frame:end_frame);

% create save video
% save_folder_path = 'D:\Public_repository\planarian\result\20230808';  % specify your desired output directory here
[~,save_file_name] = fileparts(folder_name);
% save_file_name = [save_file_name '_frame_rate_30'];
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

function write_into_video(sorted_image_files, video, folder_name)
% loop to read each image and write it into a video
for i=1:length(sorted_image_files)
    img = imread(fullfile(folder_name,sorted_image_files{i}));
    writeVideo(video, img);
end
end