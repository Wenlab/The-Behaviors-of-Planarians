image_files = dir('20230716_2315/*.jpg');  % 获取所有的.jpg文件
image_files_names = {image_files.name}';  % 提取文件名

% 对文件名排序
[~,index] = sort(cellfun(@(x) str2double(regexprep(x, '\D', '')), image_files_names));
sorted_image_files = image_files_names(index);

% 创建一个VideoWriter对象
video = VideoWriter('20230716_2315.avi'); % 您可以更改输出文件的名称
video.FrameRate = 2; % 您可以更改帧率

open(video);
write_into_video(sorted_image_files, video);
close(video);

function write_into_video(sorted_image_files, video)
% 循环读取图片，并写入视频
for i=1:length(sorted_image_files)
    img = imread(['20230716_2315/' sorted_image_files{i}]);
    writeVideo(video, img);
end
end