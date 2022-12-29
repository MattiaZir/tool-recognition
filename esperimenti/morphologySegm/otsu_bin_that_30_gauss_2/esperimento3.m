clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\otsu_bin_that_30_gauss_2");

% TOPHAT
for j = 1 : 3 : n
    im = im2double(rgb2gray(imread(images{j})));
    imf = imgaussfilt(im, 2);

    se = strel("disk", 30);
    opened = imopen(imf, se);
    tophat = imf - opened;
    bw = imbinarize(tophat);
    
    figure("Visible","off"), imshow(bw);
    saveas(gcf, "./otsu_bin_that_30_gauss_2/" + j, 'png');
end