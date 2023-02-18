clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = 1: 8:n
    im = im2double(rgb2gray(imread(images{i})));
    
    [bordi,threshOut,Gx,Gy] = edge(im, 'sobel');
    %bordi = imopen(bordi, strel('disk',30));
    figure, imshow(bordi);

    im2 = im.*bordi;
    
    figure;
    subplot(1,2,1), imshow(im), title("raw");
    subplot(1,2,2), imshow(im2), title("sobel");
    
end