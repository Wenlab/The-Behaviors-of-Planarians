function is_passed = screen_a_trajectory(trajectory)
path_length_sum = calculate_the_length_of_a_trajectory(trajectory);
length_threshold = 22*30; % 30 mm
is_passed = path_length_sum > length_threshold;
end