%% .jpg to .mp4
data_folder_path = 'D:\Public_repository\planarian\data\20230808\20230808_1937';
save_folder_path = 'D:\Public_repository\planarian\result\20230808\video';
figure_to_video(data_folder_path,save_folder_path)

%% draw trajectories of animals into the video
[~,save_file_name] = fileparts(data_folder_path);
save_file_name = strcat(save_file_name,'.mp4');
draw_trajectories_into_the_video(save_folder_path,save_file_name);