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
imsize = [150 200];
winsize = 5;
stepsize = 1;
iterations = 300;

% parametri per trainer
ksize = 3;
start_im = 1;
end_im = 82;

% parametri filtri
isGauss = 0;
isMedian = 0;
gaussStr = "";
medianStr = "";

if isGauss
    gaussSigma = 1.5;
    gaussStr = sprintf("Sigma Gauss: %i\n", gaussSigma);
end

if isMedian
    medianWin = [3 3];
    medianStr = sprintf("Grandezza finestra mediana: [%i %i]\n", medianWin);
end

segmentationMethodName = sprintf("knn_std_res%i%i_tile_%i_st_%i_it_%i_mul_%i%i_k%i", ...
    imsize,winsize, stepsize, iterations,start_im,end_im,ksize);

if salva==1
    mkdir(segmentationMethodName);
end

trainer(imsize, winsize, stepsize, ksize, start_im, end_im, segmentationMethodName);

tic % timer
% valuta la segmentazione
for i = 1 : n
    im = im2double(rgb2gray(imread(images{i})));
    im = imresize(im, imsize,"nearest");

    if isGauss
        im = imgaussfilt(im, gaussSigma);
    end

    if isMedian
        im = medfilt2(im, medianWin);
    end

    bw = segmentaEsp(im, winsize, stepsize, iterations);


    %figure,subplot(1,3,1), imshow(im);
    %subplot(1,3,2), imshow(bw);

    gt = imread(paths2gt{i}) >0;
    gt = imresize(gt, imsize, "nearest");
    
    
    %subplot(1,3,3), imshowpair(bw, gt,'falsecolor');
    diff = compareMasksV2(bw, gt); %numero di pixel di oggetti considerati sfondo + viceversa
    tmp = {i, diff};    
    res_table = [res_table; tmp];

    cm_all = [cm_all, confmat(logical(gt), bw)];
end
timed = toc;

figure, bar(res_table.("#"), res_table.errors);
title(segmentationMethodName+" Errori maschera", Interpreter="none");
xlabel("# Immagine");
ylabel("# Errori");
if salva==1
    saveas(gcf, segmentationMethodName + "/tot_errors", 'jpg');
end

cm_mean = compute_mean_confmat(cm_all);%fatto per pic binarie!!!
cm_mean.labels = {"sfondo", "forbice", "metro", "pinza", "chiave", "martello", "cacciavite", "avvitatore", "pappagallo", "lima", "pennarello", "sconosciuto"};
figure, show_confmat(cm_mean.cm_raw, cm_mean.labels);

if salva==1
    saveas(gcf, segmentationMethodName + "/conf_mat", 'jpg');
end

% Salvo i parametri
if salva==1
    fid = fopen(segmentationMethodName + "/segm_params.txt", 'wt');
    fprintf(fid, "Larghezza immagine: %i\nLunghezza immagine: " + ...
        "%i\nFinestra: %i\nStep: %i\n" + ...
        "Iterazioni: %i\n\n"+ ...
        gaussStr + medianStr +...
        "Tempo impiegato: %.3f secondi\n" + ...
        "Accuracy media: %.3f", ...
        imsize, winsize, stepsize, iterations, timed,cm_mean.accuracy);
    fclose(fid);
end


