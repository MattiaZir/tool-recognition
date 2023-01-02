clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = 1:10:n
    im = im2double(imread(images{i}));
    
   % im = medfilt2(im, [10 10]);
    %im = imfilter(im, fspecial("gaussian", 10, 1.8));

    [r c ch] = size(im);
    
    res = compute_local_descriptors(im, 30, 15, @compute_composite);
    
    labels = kmeans(res.descriptors, 2);
    counts = histcounts(labels);


    labels_image = reshape(labels, [res.nt_rows res.nt_cols]);%la pic della label è 5 volte più piccola di raw
    labels_image = imresize(labels_image, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori di labels
    
    labeled = labeloverlay(im, labels_image);
    figure, imshow(labeled);
   end

