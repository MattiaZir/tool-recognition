clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);


for j = 50 : 1 : n
    im = im2double(rgb2gray(imread(strcat("data/",images{j}))));

    se = strel("disk", 25);
    closed = imclose(im, se);
    bottomhat = closed - im;
    bw = imbinarize(bottomhat);

    im = insertText(im, [50 50], "originale");
    closed = insertText(closed, [50 50], "Chiusura con disco r=30");
    bottomhat = insertText(bottomhat, [50 50], "bottomhat");
    
    figure, montage({im closed bottomhat bw}, "size", [2 2]);
end