clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\otsu_bin_that_30");

% ESPERIMENTO 2 - TOP HAT
for j = 1 : 3 : n
    im = im2double(rgb2gray(imread(images{j})));

    se = strel("disk", 30);
    opened = imopen(im, se);
    tophat = im - opened;
    bw = imbinarize(tophat);
    
    figure("Visible","off"), imshow(bw);
    saveas(gcf, "./otsu_bin_that_30/" + j, 'png');
end