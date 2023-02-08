%divido la pic in tasselli

clear all;
close all;
im = im2double(imread("schettini.jpg"));
[r c ch] = size(im);

rng(123,"twister");%inizializzo il seed per sendere kmeans prevedibile(utile per debug)

res = compute_local_descriptors(im, 30, 1, @compute_average_color);

labels = kmeans(res.descriptors, 5);% 2o arg= gruppi/cluster

labels_image = reshape(labels, [res.nt_rows res.nt_cols]);

%la pic della label è 5 volte più piccola di raw
labels_image = imresize(labels_image, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori di labels

subplot(1,2,1), imshow(im);
subplot(1,2,2), imagesc(labels_image), axis image;


