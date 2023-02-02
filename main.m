clear;
close all;
addpath(genpath('support/'));
% [images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
[images, symbolicLabels, paths2gt, labels_meaning] = readlists();
n = numel(images); 
scale_res = [154 205];

for i =  1 : 10 %lo provo sul test set
    imHD = im2double(imread(images{i}));
    img = rgb2gray(imresize(imHD, scale_res, "nearest"));%opero sull'immagine low-res
    bw = segmentaViaClassificazione(img);


    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), scale_res,"nearest")>0;    
    gt = uint8(gt); 

    cc = labelingCompConn(bw);

    [cetriOggetti, labelsObjs, immagineLayerOggettiTrovati, ~] = classificaOggetti(cc, img, labels_meaning);
    figure, imagesc(immagineLayerOggettiTrovati); % Decommentami se vuoi vedere le componenti connesse/segmentaz
    fig = mostraGuessedLabels(imresize(imHD, scale_res.*3, "nearest"), scale_res, cetriOggetti, labelsObjs);
    figure, imshow(fig);

end
