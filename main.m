clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 
scale_res = [154 205];

for i =  1 : n/2 +5 %test set
    imHD = im2double(imread(images{i}));
    img = rgb2gray(imresize(imHD, scale_res, "nearest"));%opero sull'immagine low-res
    bw = segmentaViaClassificazione(img);
    cc = labelingCompConn(bw);


    [cetriOggetti, labelsObjs, immagineLayerOggettiTrovati] = classificaOggetti(cc, img, labels_meaning);
%     figure, imagesc(immagineLayerOggettiTrovati);%valori uguali qui <-->classi/label uguali
    fig = mostraGuessedLabels(imresize(imHD, scale_res.*2, "nearest"), scale_res, cetriOggetti, labelsObjs);
    
    if(i==1||i==2||i==3||i==4)
        subplot(2,2,i), imshow(fig);
    else
        figure, imshow(fig);
    end
end
