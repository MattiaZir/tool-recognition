clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = floor(n/2): n
    im = im2double(imread(strcat("data/",images{i})));
    [r c ch] = size(im);

    rng(123,"twister");%inizializzo il seed per sendere kmeans prevedibile(utile per debug)
    
    res = compute_local_descriptors(im, 30, 15, @compute_average_color);
    
    labels = kmeans(res.descriptors, 2);% 2o arg= gruppi/cluster
    
    labels_image = reshape(labels, [res.nt_rows res.nt_cols]);
    
    %la pic della label è 5 volte più piccola di raw
    labels_image = imresize(labels_image, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori di labels
    figure;
    subplot(1,2,1), imshow(im);
    subplot(1,2,2), imagesc(labels_image), axis image;

end

