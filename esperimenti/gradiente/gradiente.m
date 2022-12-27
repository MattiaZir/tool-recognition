clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = 1: n/4
    im = im2double(rgb2gray(imread(strcat("data/",images{i}))));
    
    [bordi,threshOut,Gx,Gy] = edge(im, 'sobel');
    %bordi = imopen(bordi, strel('disk',30));
    figure, imshow(bordi);

    im2 = im.*bordi;
    
    figure, imshow(im2);
    
    figure, imshow(bw);
end