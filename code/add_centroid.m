clc; clear; close all;

% read
folder_name = 'F:\1_learning\research\planarian\data\20230716 preliminary';
file_name = '20230716_2315.avi';
full_path = fullfile(folder_name,file_name);
video = VideoReader(full_path);

% save
output_video_file = strrep(full_path,'.avi','_binarized_with_trajectory_temp.mp4');
output_video = VideoWriter(output_video_file, 'MPEG-4');
open(output_video);

% exclude background
mask_of_background = get_mask_of_background(video);

% centroid distance threshold
distance_threshold = 100;  % Set this according to your specific video

% initialize
video.currentTime = 150;
count_frame = 0;
trajectories = {};  % Initialize to empty cell array
has_successor = [];  % Initialize to empty array
is_drawed = [];

% loop
while hasFrame(video)
    count_frame = count_frame + 1;
    
    %% get binaryFrame
    [binary_frame,properties_screened] = get_binary_frame(video,mask_of_background);

    %% draw the trajectory
    [binary_frame_RGB,trajectories,has_successor,is_drawed] = draw_trajectories(trajectories,has_successor,binary_frame,properties_screened,distance_threshold,is_drawed);

    %% save
    writeVideo(output_video, binary_frame_RGB);

    if video.currentTime > 350
        break;
    end
end
close(output_video);
close all;

trajectories_new = screen_trajectories(trajectories);