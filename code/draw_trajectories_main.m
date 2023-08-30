clc; clear; close all;

%% read
folder_name = 'F:\1_learning\research\planarian\result\20230808\video';
file_name = '20230808_1906.mp4';
full_path = fullfile(folder_name,file_name);
video = VideoReader(full_path);

%% save
output_video_file = strrep(full_path,'.mp4','_binarized_with_trajectory_temp.mp4');
output_video = VideoWriter(output_video_file, 'MPEG-4');
open(output_video);

output_video_file_2 = strrep(full_path,'.mp4','_original_vieo_with_trajectory_temp.mp4');
output_video_2 = VideoWriter(output_video_file_2, 'MPEG-4');
open(output_video_2);

%% exclude background
mask_of_background = get_mask_of_background(video);
imshow(mask_of_background);
folder_name = 'F:\1_learning\research\planarian\result\20230808\background';
file_name = strrep(file_name,'.mp4','');
full_path = fullfile(folder_name,file_name);
saveas(gcf,full_path,'png')

%% centroid distance threshold
distance_threshold = 100;  % Set this according to your specific video

%% initialize
video.currentTime = 0;
count_frame = 0;
trajectories = {};
has_successor = [];
is_drawed = [];
trajectories_2 = {};
has_successor_2 = [];
is_drawed_2 = [];

%% loop to process each frame 1 by 1
while hasFrame(video)
    count_frame = count_frame + 1;
    
    %% get binaryFrame and RGB frame
    [binary_frame,animals_screened,RGB_frame] = get_binary_frame(video,mask_of_background);

    %% draw the trajectory to the binary frame
    [binary_frame_RGB,trajectories,has_successor,is_drawed] = draw_trajectories(trajectories,has_successor,binary_frame,animals_screened,distance_threshold,is_drawed);
    
    % save
    writeVideo(output_video, binary_frame_RGB);
    
    %% draw the trajectory to the original frame
    [RGB_frame,trajectories_2,has_successor_2,is_drawed_2] = draw_trajectories(trajectories_2,has_successor_2,RGB_frame,animals_screened,distance_threshold,is_drawed_2);

    % save
    writeVideo(output_video_2, RGB_frame);
    
    %% using a small period to check if the code is right
    % if video.currentTime > 100
    %     break;
    % end

end
close(output_video);
close(output_video_2);
close all;

%% get the trajectories which are long enough
trajectories_new = screen_trajectories(trajectories);