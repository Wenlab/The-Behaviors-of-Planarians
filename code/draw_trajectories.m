function [binary_frame_RGB,trajectories,has_successor,is_drawed] = draw_trajectories(trajectories,has_successor,binary_frame,properties_screened,distance_threshold,is_drawed)

%% get the number of points of each trajectory
n_point_of_each_trajectory_pre = cellfun(@(x) size(x,1),trajectories);

%% get all centroids in the current frame
current_centroids = cat(1, properties_screened.Centroid); % the 1st column is x and the 2nd column is y
n_current_centroid = size(current_centroids, 1);

%% loop to process all centroids in the current frame
for i = 1:n_current_centroid

    % initialize
    current_centroid = current_centroids(i, :);
    min_dist = inf; % initialize to inf
    closest_centroid_idx = -1; % initialize to -1
    n_trajectory = size(trajectories, 2);

    % loop to find closest centroid among all centoird in the last frame
    for j = 1:n_trajectory
        if has_successor(j)
            last_centroid = trajectories{j}(end, :);
            dist = norm(current_centroid - last_centroid);
            if dist < min_dist
                min_dist = dist;
                closest_centroid_idx = j;
            end
        end
    end

    % if min dist is smaller than threshold
    if min_dist < distance_threshold
        % an animal that already exists
        trajectories{closest_centroid_idx} = [trajectories{closest_centroid_idx}; current_centroid];
        has_successor(closest_centroid_idx) = true;
    elseif min_dist >= distance_threshold
        % a new animal, start a new trajectory
        trajectories{end+1} = current_centroid;
        has_successor(end+1) = true;
        is_drawed(end+1) = false;
    end

end

%% get trajectories with no successor
n_point_of_each_trajectory_post = cellfun(@(x) size(x,1),trajectories);
for i = 1:length(n_point_of_each_trajectory_pre)
    if n_point_of_each_trajectory_pre(i) == n_point_of_each_trajectory_post(i)
        has_successor(i) = false;
    end
end

%% create an RGB version of the binary frame
binary_frame_RGB = uint8(cat(3, binary_frame, binary_frame, binary_frame) * 255);

%% draw
for i = find(~has_successor)
    % If the trajectory does't have a successor
    if ~is_drawed(i)
        % If the trajectory has not been drawed
        trajectory = trajectories{i};
        path_length_sum = calculate_the_length_of_a_trajectory(trajectory);
        length_threshold = 22*30; % 30 mm
        if path_length_sum > length_threshold
            binary_frame_RGB = insert_trajectory(binary_frame_RGB, trajectory, 'red');
        else
            binary_frame_RGB = insert_trajectory(binary_frame_RGB, trajectory, 'black');
            is_drawed(i) = true;
        end        
    end    
end

for i = find(has_successor)
    % If the trajectory has a successor, color it cyan
    trajectory = trajectories{i};
    binary_frame_RGB = insert_trajectory(binary_frame_RGB, trajectory, 'cyan');
end

end

function binary_frame_RGB = insert_trajectory(binary_frame_RGB, trajectory, color_str)
    linePoints = [trajectory(1:end-1, :), trajectory(2:end, :)];
    binary_frame_RGB = insertShape(binary_frame_RGB, 'Line', linePoints, 'Color', color_str, 'LineWidth', 2);
end