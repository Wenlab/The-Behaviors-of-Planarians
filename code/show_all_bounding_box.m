function show_all_bounding_box(binaryFrame,bounding_box_screened)

% Get the number of bounding boxes
numBoundingBoxes = length(bounding_box_screened);

% Iterate through each bounding box
for k = 1:numBoundingBoxes
    % Get the bounding box
    bbox = bounding_box_screened(k).BoundingBox;

    % Calculate the start and end indices of the bounding box
    xStart = round(bbox(1));
    yStart = round(bbox(2));
    xEnd = xStart + round(bbox(3)) - 1;
    yEnd = yStart + round(bbox(4)) - 1;

    % Create the image
    bboxImage = binaryFrame(yStart:yEnd, xStart:xEnd);

    % Display the image
    figure;
    imshow(bboxImage);
    title(sprintf('Bounding Box %d', k));
end

end