clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 
scale_res = [154 205];

for i =  1 : 5 %test set
    imHD = im2double(imread(images{i}));
    img = rgb2gray(imresize(imHD, scale_res, "nearest"));%opero sull'immagine low-res
    bw = segmentaViaClassificazione(img);
     cc = labelingCompConn(bw);

    [cetriOggetti, labelsObjs, immagineLayerOggettiTrovati] = classificaOggetti(cc, labels_meaning);
    figure, imagesc(immagineLayerOggettiTrovati);%valori uguali qui <-->classi/label uguali
    fig = mostraGuessedLabels(imHD, scale_res, cetriOggetti, labelsObjs);
    figure, imshow(fig);
    cetriOggetti
    
end
