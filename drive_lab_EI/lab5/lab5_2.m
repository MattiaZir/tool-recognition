%divido la pic in tasselli

clear all;
close all;
im = im2double(imread("segmentation.png"));
tmp = rgb2ycbcr(im);
tmp(:,:,1) = [];%butto la y gurdo solo la crominanza

[r c ch] = size(im);


res = compute_local_descriptors(tmp, 5, 5, @compute_average_color);

labels = kmeans(res.descriptors, 4);% 2o arg= gruppi/cluster

labels_image = reshape(labels, [res.nt_rows res.nt_cols]);

%la pic della label è 5 volte più piccola di raw
labels_image = imresize(labels_image, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori di labels

subplot(1,2,1), imshow(im);
subplot(1,2,2), imagesc(labels_image), axis image;


