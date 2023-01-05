clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 

for i =  1 : n %test set
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, [154 205],"nearest"));

    bw = segmentaViaClassificazione(im);
    cc = labelingCompConn(bw);
    figure, imagesc(cc);
end
