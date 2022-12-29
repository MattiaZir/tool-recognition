clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);
res_table = cell2table(cell(0,3), 'VariableNames', {'#', 'label', 'errors'});

for k = 1:n
    % Essendo le immagini in png, devo cambiare la stringa con strrep
    im_name = strrep(images{k}, '.jpg', '.png');
    gt_im = imread(strcat("data/annotaz/", im_name)) > 0;
    gen_im = imread(strcat("data/generated/", im_name)) > 0;

    image_diff = imabsdiff(gt_im, gen_im);
    diff_sum = sum(image_diff(:));

    tmp = {k, labels{k}, diff_sum};


    res_table = [res_table; tmp];
end

% Creazione dei grafici
figure, bar(res_table.("#"), res_table.errors);
title("Errori maschera");
xlabel("# Immagine");
ylabel("# Errori");

% Raggruppo le statistiche
grouped = grpstats(res_table, "label", ["sum","min", "max", "mean", "std"]);

% ERRORI TOTALI
figure, bar(categorical(grouped.label), grouped.sum_errors);
title("Totale errori per label");
xlabel("Label");
ylabel("# Errori");

% MEDIA ERRORI
figure, bar(categorical(grouped.label), grouped.mean_errors);
title("Media errori per label");
xlabel("Label");
ylabel("# Errori");

