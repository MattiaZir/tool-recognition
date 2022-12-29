clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\otsu_bin_bhat_30");

% ESPERIMENTO 1 - BOTTOM HAT
for j = 1 : 3 : n
    im = im2double(rgb2gray(imread(images{j})));

    se = strel("disk", 30);
    closed = imclose(im, se);
    bottomhat = closed - im;
    bw = imbinarize(bottomhat);
    
    figure("Visible","off"), imshow(bw);
    saveas(gcf, "./otsu_bin_bhat_30/" + j, 'png');
end