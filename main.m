%clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 

for i =  8 : 18 %test set
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, [154 205],"nearest"));

    bw = segmentaViaClassificazione(im);
    cc = labelingCompConn(bw, 0);
    figure, imagesc(cc);
    cc = labelingCompConn(bw, 1);
    figure, imagesc(cc);
end
