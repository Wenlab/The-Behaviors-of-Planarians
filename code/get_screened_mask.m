function mask_of_screened_bounding_box = get_screened_mask(bounding_box_screened,videoWidth,videoHeight)

mask_of_screened_bounding_box = false(videoHeight,videoWidth);
for k = 1:length(bounding_box_screened)
    xStart = round(bounding_box_screened(k).BoundingBox(1));
    yStart = round(bounding_box_screened(k).BoundingBox(2));
    xEnd = xStart + round(bounding_box_screened(k).BoundingBox(3)) - 1;
    yEnd = yStart + round(bounding_box_screened(k).BoundingBox(4)) - 1;

    % Update the mask
    mask_of_screened_bounding_box(yStart:yEnd, xStart:xEnd) = true;
end

end