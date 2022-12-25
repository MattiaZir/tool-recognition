clear;
close all;
addpath(genpath('../../support/'));
[images, labels] = readlists();
n = numel(images);

for i = 1 : n/5
    im = im2double(imadjust(rgb2gray(imread(strcat("data/",images{i})))));

    imf = medfilt2(im, [5 5]);
    imf = imfilter(imf, fspecial("gaussian", 7, 1.2));

    imf = imf .^0.5;%gamma-correggo: l'oggetto è scuro -> gamma <1 (espando scuri)
    [L,Centers] = imsegkmeans(uint8(imf),2);
    B = labeloverlay(imf,L);
    C = logical(L==2);
    figure, imshowpair(B, C, "montage");
end