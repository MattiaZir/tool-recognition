clear all;
close all;
im = im2double(imread("colortext.png"));

[r c ch] = size(im);


res = compute_local_descriptors(im, 20, 5, @compute_composite);

labels = kmeans(res.descriptors, 6);% 2o arg= gruppi/cluster

labels_image = reshape(labels, [res.nt_rows res.nt_cols]);

%la pic della label è 5 volte più piccola di raw
labels_image = imresize(labels_image, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori di labels

subplot(1,2,1), imshow(im);
subplot(1,2,2), imagesc(labels_image), axis image;
