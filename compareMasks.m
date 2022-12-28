clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);
results = zeros(n, 1);

for k = 1:n
    % Essendo le immagini in png, devo cambiare la stringa con strrep
    im_name = strrep(images{k}, '.jpg', '.png');
    gt_im = imread(strcat("data/annotaz/", im_name)) > 0;
    gen_im = imread(strcat("data/generated/", im_name)) > 0;


    image_diff = imabsdiff(gt_im, gen_im);
    results(k) = sum(image_diff(:));
end

figure, bar(1:n, results);
title("Errori maschera");
xlabel("# Immagine");
ylabel("# Errori");
