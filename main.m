%clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 

for i =  8 : n %test set
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, [154 205],"nearest"));
    bw = segmentaViaClassificazione(im);
    cc = labelingCompConn(bw);
    [bBoxLocs, lbls] = classify(cc);
    
    fig = insertObjectAnnotation(im, "rectangle", bBoxLocs, lbls);

    figure, imshow(fig);
end
