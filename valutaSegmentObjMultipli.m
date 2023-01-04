%per la visualizzazione / salvataggio stime accuratezza segmentazione pic
%con + oggetti. nota che salva dentro la cartella segmentationMethodName/multiple

clear;
close all;
addpath(genpath('support/'));
[images, dummy, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images);

res_table = cell2table(cell(0,2), 'VariableNames', {'#', 'errors'});

%  lui salva in
% esperimenti/segmentationMethodName/multiple/ i 3 grafici e 'grouped' serializzato.
segmentationMethodName = 'kmeans su lbp tile 30x30 step 15/multiple';
salva = 0;

for i = 1 : n % solo 1 pic ha la gt quindi... 1:1 e non 1:n
    im = im2double(rgb2gray(imread(images{i})));
    im = medfilt2(im, [10 10]);
    im = imfilter(im, fspecial("gaussian", 10, 1.8));

    
    bw = segmenta(im);


    figure,subplot(1,3,1), imshow(im);
    bw = imopen(bw, strel('disk',5));
    bw = imclose(bw, strel('disk',20));
    subplot(1,3,2), imshow(bw);

    gt = imread(paths2gt{i}) >0;
    
    
    subplot(1,3,3), imshowpair(bw, gt,'falsecolor');
    diff = compareMasksV2(bw, gt); %numero di pixel di oggetti considerati sfondo + viceversa
    tmp = {i, diff};    
    res_table = [res_table; tmp];


end

if salva==1
    cd("esperimenti/");
    mkdir(segmentationMethodName);
end

figure, bar(res_table.("#"), res_table.errors);
title(segmentationMethodName+" Errori maschera");
xlabel("# Immagine");
ylabel("# Errori");
if salva==1
    saveas(gcf, segmentationMethodName + "/tot_errors", 'jpg');
end





