function out = compute_signature(figure, centroids)
    boundary = bwboundaries(figure);
    x_bound = boundary{1, 1}(:, 1);
    y_bound = boundary{1, 1}(:, 2);

    distances = sqrt((y_bound-centroids(1)).^2 + (x_bound-centroids(2)).^2);
    out = mat2gray(distances);
end