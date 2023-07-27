function trajectories_new = screen_trajectories(trajectories)
trajectories_new = {};
for i = 1:size(trajectories,2)
    trajectory = trajectories{i};
    path_length_sum = calculate_the_length_of_a_trajectory(trajectory);
    length_threshold = 22*30;
    if path_length_sum > length_threshold
        trajectories_new{end+1} = trajectory';
    end
end
trajectories_new = trajectories_new';
end