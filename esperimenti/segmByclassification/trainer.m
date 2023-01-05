clear;
close all;
addpath(genpath('support/'));
[images, ~, paths2gt, labels_meaning] = readlists();
n = numel(images); 
%classificatore knn per trovare i pixel di una immagine che sono di obj

train_values=[];
train_labels=[];

for i = 1 : 1: 82
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, [154 205],"nearest"));
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), [154 205],"nearest")>0;    
    gt = uint8(gt);
    [r c ~] = size(im);
    res = compute_local_descriptors(im, 15, 1, @compute_std_dev2);    
    [rs,cs,ch] = size(res.descriptors); % 12288 x 59 x 1
    train_values = vertcat(train_values, res.descriptors);
    labels_vector = reshape(gt, [r*c 1]); % 12288 x 1 vettore
    train_labels = vertcat(train_labels, labels_vector);

end

classifier = fitcknn(train_values, train_labels, "NumNeighbors", 3);
save("classifier", "classifier");