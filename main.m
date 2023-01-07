%clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 

for i =  8 : n %test set
    im = im2double(imread(images{i}));
    figure, subplot(2,2,1), imshow(im);
    im = rgb2gray(imresize(im, [154 205],"nearest"));
    subplot(2,2,4), imshow(im);
%     bw = segmentaViaClassificazione(im);
%     cc = labelingCompConn(bw);
%     figure(i), subplot(2,1,2),imagesc(cc);
%     subplot(2,1,1), imshow(im);
end
