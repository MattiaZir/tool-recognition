%clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 
scale_res = [154 205];

for i =  8 : n %test set
    im = im2double(imread(images{i}));
    img = rgb2gray(imresize(im, scale_res, "nearest"));
    bw = segmentaViaClassificazione(img);
    cc = labelingCompConn(bw);
    [bBoxLocs, lbls] = classify(cc);
    
    % Questo crea l'immagine con le dimensioni originali e a colori
    fig = createAnnotatedImage(im, scale_res, bBoxLocs, lbls);
    figure, imshow(fig);
end
