clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 
scale_res = [154 205];

for i =  1 : n-8 %test set
    im = im2double(imread(images{i}));
    img = rgb2gray(imresize(im, scale_res, "nearest"));
    bw = segmentaViaClassificazione(img);
     cc = labelingCompConn(bw);
    [bBoxLocs, labels] = classificaOggetti(cc, labels_meaning);
%     labels = lbls{:};
    for j= 1 : numel(unique(labels))
        j
    end
end