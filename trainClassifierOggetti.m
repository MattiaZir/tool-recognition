clear;
close all;
addpath(genpath('support/'));
[images, labelsLette, paths2gt, ~] = readlists();
n = numel(images); 

scale_res = [154 205];

tabellaDescrittori=table;

for i = 1 : 1: n
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, scale_res,"nearest"));
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), scale_res,"nearest")>0;    
    gt = uint8(gt);   

    gt = imclose(gt, strel('disk', 2));%la gt non è perfetta...
    
    res = compute_local_descriptors(im, 30, 1, @compute_std_dev2);
    stdPuntuale = reshape(res.descriptors, [res.nt_rows res.nt_cols]);
    

    featureTableRow = estraiFeatureDaRegione(gt, stdPuntuale);%bypasso classificaoggetti.m tanto esso serve se ho + c.connesse e per il mostrare la label nei centroidi
    %bisogna ricordarsi di togliere le feature che pure classificaoggetti.m
    %toglie e passare i descrittori di texture come fa lui    
    featureTableRow = removevars(featureTableRow, ["Centroid"]);
    featureTableRow.Label = labelsLette(i);
    tabellaDescrittori = [tabellaDescrittori; featureTableRow];
    
end


tabSenzaLabel = removevars(tabellaDescrittori, ["Label"]);
classifierOggetti = prune(fitctree(tabSenzaLabel, tabellaDescrittori.Label));

save("classifierOggetti", "classifierOggetti");


%altri esperimenti:
% classifierOggetti = fitcauto(tabSenzaLabel, tabellaDescrittori.Label);
% classifierOggetti = fitcknn(tabSenzaLabel, tabellaDescrittori.Label, "NumNeighbors",3);






