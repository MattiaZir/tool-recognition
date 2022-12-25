clear;
close all;
addpath(genpath('../../support/'));
[images, labels] = readlists();
n = numel(images);

for i = 1 : n/5
    im = im2double(rgb2gray(imread(strcat("data/",images{i}))));
    imf = medfilt2(im, [5 5]);
    imf = imfilter(imf, fspecial("gaussian", 7, 1.2));

    [L,Centers] = imsegkmeans(uint8(imf),2);
    B = labeloverlay(imf,L);
    figure, imshowpair(imf, B, "montage");
end