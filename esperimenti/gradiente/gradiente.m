clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = 1: n/4
    im = im2double(rgb2gray(imread(strcat("data/",images{i}))));
    
    [bordi,threshOut,Gx,Gy] = edge(im, 'prewitt');
    bordi = imclose(bordi, strel('disk',3));
    figure, imshow(bordi);

    im2 = im.*bordi;
    
    figure, imshow(im2);
    soglie = adaptthresh(im2);

    bw = imbinarize(im, soglie);
    bw = imclose(bw, strel('disk', 10));
    bw = imopen(bw, strel('disk', 5));
    
    figure, imshow(bw);
end