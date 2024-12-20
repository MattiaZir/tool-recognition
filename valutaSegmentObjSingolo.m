%per la visualizzazione / salvataggio stime accuratezza segmentazione

clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, dummy] = readlists();
n = numel(images);
res_table = cell2table(cell(0,3), 'VariableNames', {'#', 'label', 'errors'});

% lui salva in
% esperimenti/segmentationMethodName/ i 3 grafici e 'grouped' serializzato.
segmentationMethodName = 'kmeans su lbp tile 30x30 step 15';
salva = 1;

for i = 1 : n/4
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
    tmp = {i, symbolicLabels(i), diff};
    
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


grouped = grpstats(res_table, "label", ["sum", "min", "max", "mean", "std"]);

% ERRORI TOTALI
figure, bar(categorical(grouped.label), grouped.sum_errors);
title(segmentationMethodName+" Totale errori per label");
xlabel("Label");
ylabel("# Errori");
if salva==1
    saveas(gcf, segmentationMethodName + "/label_tot_errors", 'jpg');
end


% MEDIA ERRORI
figure, bar(categorical(grouped.label), grouped.mean_errors);
title(segmentationMethodName+" Media errori per label");
xlabel("Label");
ylabel("# Errori");
if salva==1
    saveas(gcf, segmentationMethodName + "/label_avg_errors", 'jpg');

    writetable(grouped, segmentationMethodName + "/data.csv");%serializzo grouped
end