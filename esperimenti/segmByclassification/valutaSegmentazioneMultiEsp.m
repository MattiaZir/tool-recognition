clear;
close all;
addpath(genpath('support/'));
[images, dummy, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images);
res_table = cell2table(cell(0,2), 'VariableNames', {'#', 'errors'});

%  lui salva in
% esperimenti/segmentationMethodName/multiple/ i 3 grafici e 'grouped' serializzato.
salva = 1;
cm_all = [];

% parametri per segmentazione
imsize = [154 205];
winsize = 10;
stepsize = 1;
iterations = 300;

segmentationMethodName = sprintf('03_knn_std_tile_%i_step_%i_iters_%i_multiple', ...
    winsize, stepsize, iterations);

tic % timer
% valuta la segmentazione
for i = 1 : n
    im = im2double(rgb2gray(imread(images{i})));
    im = imresize(im, imsize,"nearest");

    bw = segmentaEsp(im, winsize, stepsize, iterations);


    %figure,subplot(1,3,1), imshow(im);
    %subplot(1,3,2), imshow(bw);

    gt = imread(paths2gt{i}) >0;
    gt = imresize(gt, imsize, "nearest");
    
    
    %subplot(1,3,3), imshowpair(bw, gt,'falsecolor');
    diff = compareMasksV2(bw, gt); %numero di pixel di oggetti considerati sfondo + viceversa
    tmp = {i, diff};    
    res_table = [res_table; tmp];

    cm_all = [cm_all confmat(logical(gt), bw)];
end
timed = toc;

if salva==1
    mkdir(segmentationMethodName);
end

figure, bar(res_table.("#"), res_table.errors);
title(segmentationMethodName+" Errori maschera");
xlabel("# Immagine");
ylabel("# Errori");
if salva==1
    saveas(gcf, segmentationMethodName + "/tot_errors", 'jpg');
end

cm_mean = compute_mean_confmat(cm_all);
figure, show_confmat(cm_mean.cm_raw, cm_mean.labels);

if salva==1
    saveas(gcf, segmentationMethodName + "/conf_mat", 'jpg');
end

% Salvo i parametri
if salva==1
    fid = fopen(segmentationMethodName + "/segm_params.txt", 'wt');
    fprintf(fid, "Larghezza immagine: %i\nLunghezza immagine: " + ...
        "%i\nFinestra: %i\nStep: %i\nIterazioni: %i\n" + ...
        "Tempo impiegato: %.3f secondi", ...
        imsize, winsize, stepsize, iterations, timed);
    fclose(fid);
end

