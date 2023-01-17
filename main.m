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
%      figure, imagesc(cc);
    [bBoxLocs, lbls] = classificaOggetti(cc);
    lbls
    bBoxLocs
    % Questo crea l'immagine con le dimensioni originali e a colori
    fig = mostraGuessedLabels(im, scale_res, bBoxLocs, lbls);
    figure, imshow(fig);
end
