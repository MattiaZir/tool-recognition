clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 
scale_res = [154 205];
res_table = cell2table(cell(0,2), 'VariableNames', {'#', 'errors'});
methodName = 'knn k=3 RapportoAssi Circularity Solidity EulerNumber mediaStdOggetto';
salva =0;
 
for i =  1 : n %test set
    imHD = im2double(imread(images{i}));
    img = rgb2gray(imresize(imHD, scale_res, "nearest"));%opero sull'immagine low-res
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), scale_res,"nearest");    
    bw = segmentaViaClassificazione(img);
    cc = labelingCompConn(bw);

    [cetriOggetti, labelsObjs, immagineLayerOggettiTrovati] = classificaOggetti(cc, img, labels_meaning);
    diff = compareMasksV2(gt, immagineLayerOggettiTrovati);%num pixel diversi


    tmp = {i, diff};    
    res_table = [res_table; tmp];
    
end


if salva==1
    cd("esperimenti/");
    mkdir(methodName);
end

figure, bar(res_table.("#"), res_table.errors);
title(methodName+" Errori maschera");
xlabel("# Immagine");
ylabel("# Errori");
if salva==1
    saveas(gcf, methodName + "/tot_errors", 'jpg');
end



