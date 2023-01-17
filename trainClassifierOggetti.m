clear;
close all;
addpath(genpath('support/'));
[images, labelsLette, paths2gt, ~] = readlists();
n = numel(images); 


tabellaDescrittori=table;

for i = 1 : 1: 20
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, [154 205],"nearest"));
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), [154 205],"nearest")>0;    
    gt = imclose(gt, strel('disk', 2));
    featureTableRow = extractor(gt);
    featureTableRow
    featureTableRow.Label = labelsLette(i);
    tabellaDescrittori = [tabellaDescrittori; featureTableRow];
    
end



% 
% classifierOggetti = fitcknn(train_values, train_labels, "NumNeighbors", 3);
% save("classifierOggetti", "classifierOggetti");











