clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);
mkdir(".\01_clustering");

for i = 1:7:n
    im = im2double(imread(images{i}));
    
    for k = 1:3
        im(:,:,k) = imfilter(im(:,:,k), fspecial("gaussian", 10, 2));
    end

    [r c ch] = size(im);
    
    res = compute_local_descriptors(im(:,:,1), 15, 5, @compute_std_dev);
    
    labels = kmeans(res.descriptors, 3);
    counts = histcounts(labels);


    labels_image = reshape(labels, [res.nt_rows res.nt_cols]);%la pic della label è 5 volte più piccola di raw
    labels_image = imresize(labels_image, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori di labels
    
    over = labeloverlay(im, labels_image);
    figure, imshow(over);
    saveas(gcf, "./01_clustering/" + i, 'png');
end

