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
    featureTableRow = extractor(gt);
    featureTableRow.Label = labelsLette(i);
    tabellaDescrittori = [tabellaDescrittori; featureTableRow];
    
end


tabSenzaLabel = removevars(tabellaDescrittori, ["Label"]);

classifierOggetti = fitcknn(tabSenzaLabel, tabellaDescrittori.Label, "NumNeighbors",3);
save("classifierOggetti", "classifierOggetti");











