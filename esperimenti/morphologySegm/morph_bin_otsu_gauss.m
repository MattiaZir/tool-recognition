clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\otsu_bin_that_30_gauss_2");

%% BOTTOM HAT
% for j = 1 : n
%     im = im2double(rgb2gray(imread(images{j})));
% 
%     se = strel("disk", 30);
%     closed = imclose(im, se);
%     bottomhat = closed - im;
%     bw = imbinarize(bottomhat);
% 
%     im = insertText(im, [50 50], "originale");
%     closed = insertText(closed, [30 30], "Chiusura con disco r=30");
%     bottomhat = insertText(bottomhat, [30 30], "bottomhat");
%     
%     figure("Visible","off"), imshow(bw);
%     saveas(gcf, "./otsu_bin_bhat_30/" + j, 'png');
% end

%% TOPHAT
for j = 1 : n
    im = im2double(rgb2gray(imread(images{j})));
    imf = imgaussfilt(im, 2);

    se = strel("disk", 30);
    opened = imopen(imf, se);
    tophat = imf - opened;
    bw = imbinarize(tophat);
    
    figure("Visible","off"), imshow(bw);
    saveas(gcf, "./otsu_bin_that_30_gauss_2/" + j, 'png');
end