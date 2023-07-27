function centroids = draw_centroids(centroids,properties_screened,distance_threshold,count)
centroids{count} = cat(1, properties_screened.Centroid);

% Draw lines from closest centroids in previous frame
if count > 1
    currentCentroids = centroids{count};
    previousCentroids = centroids{count-1};

    hold on;
    for i = 1:size(currentCentroids, 1)
        minDist = inf;
        closestCentroidIdx = -1;
        for j = 1:size(trajectories, 2)
            if hasSuccessor(j)
                lastCentroid = trajectories{j}(end, :);
                dist = norm(currentCentroids(i, :) - lastCentroid);
                if dist < minDist
                    minDist = dist;
                    closestCentroidIdx = j;
                end
            end
        end
        if minDist < distance_threshold
            trajectories{closestCentroidIdx} = [trajectories{closestCentroidIdx}; currentCentroids(i, :)];
            hasSuccessor(closestCentroidIdx) = true;
        else
            % This is likely a new animal, so start a new trajectory
            trajectories{end+1} = [currentCentroids(i, :)];
            hasSuccessor(end+1) = true;
        end
    end

    for i = find(~hasSuccessor)
        % If the trajectory has no successor, color it red
        plot(trajectories{i}(:, 1), trajectories{i}(:, 2), 'r-');
        plot(trajectories{i}(end, 1), trajectories{i}(end, 2), 'r*');
    end
    for i = find(hasSuccessor)
        % If the trajectory has a successor, color it cyan
        plot(trajectories{i}(:, 1), trajectories{i}(:, 2), 'c-');
        plot(trajectories{i}(end, 1), trajectories{i}(end, 2), 'c*');
    end

    % Reset hasSuccessor to false for next iteration
    hasSuccessor(:) = false;
    hold off;
end
end