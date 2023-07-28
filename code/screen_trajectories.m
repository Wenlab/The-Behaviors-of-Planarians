function trajectories_new = screen_trajectories(trajectories)
trajectories_new = {};
for i = 1:size(trajectories,2)
    trajectory = trajectories{i};
    is_passed = screen_a_trajectory(trajectory);
    if is_passed
        trajectories_new{end+1} = trajectory';
    end
end
trajectories_new = trajectories_new';
end