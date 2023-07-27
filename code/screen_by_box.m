function bounding_box = screen_by_box(bounding_box)
valid_indices = [];
for k = 1 : length(bounding_box)
    thisBB = bounding_box(k).BoundingBox;
    thisArea = bounding_box(k).Area;
    if thisBB(3) > 5 && thisBB(4) > 5 && thisArea > 200
        valid_indices = [valid_indices, k];
    end
end
bounding_box = bounding_box(valid_indices);
end