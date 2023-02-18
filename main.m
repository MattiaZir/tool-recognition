clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
% [images, symbolicLabels, paths2gt, labels_meaning] = readlists();
n = numel(images); 
scale_res = [154 205];

for i =  3:3%8 : 2: 27 %lo provo sul test/train set
    imHD = im2double(imread(images{i}));
    img = rgb2gray(imresize(imHD, scale_res, "nearest"));%opero sull'immagine low-res
    bw = segmentaViaClassificazione(img);
    figure, imshow(bw);

    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), scale_res,"nearest");% >0;    
    gt = uint8(gt); 

%     cc = labelingCompConn(bw);
%     figure, imagesc(cc);

    %anche se gli passo la gt scazza tutto
%     [cetriOggetti, labelsObjs, immagineLayerOggettiTrovati, ~] = classificaOggetti(gt, img, labels_meaning);
%     figure, imagesc(immagineLayerOggettiTrovati); % Decommentami se vuoi vedere le componenti connesse/segmentaz
%     fig = mostraGuessedLabels(imresize(imHD, scale_res.*3, "nearest"), scale_res, cetriOggetti, labelsObjs);
%     figure, imshow(fig);

end


% myhu = [moment(maskRegione, 1,"all"), moment(maskRegione, 2,"all"), moment(maskRegione, 3,"all"), moment(maskRegione, 4,"all"), moment(maskRegione, 5,"all"), moment(maskRegione, 6,"all"), moment(maskRegione, 7,"all")];