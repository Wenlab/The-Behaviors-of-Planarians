function path_length_sum = calculate_the_length_of_a_trajectory(trajectory)

points = trajectory'; % 1st row is x, 2nd row is y
disp_vectors = (points(:, 2:end) - points(:, 1:end - 1));
path_lengths = sqrt(sum(disp_vectors.^2, 1));
path_length_sum = sum(path_lengths);

end