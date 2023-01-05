clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\02_polarity_biggestlabels");


for j = 1 : 1 : n
    im = im2gray(im2double(imread(images{j})));

    thresh = graythresh(im);
    polarity = 'dark';

    if (thresh > 0.5)
        polarity = 'bright';
    end
    
    bw = imcomplement(imbinarize(im, "adaptive", "ForegroundPolarity", polarity, "Sensitivity", thresh));
    bwf = imopen(bw, strel('disk', 5));
    bwlabs = bwlabel(bwf, 8);

    % metto in ordine le aree
    areas = regionprops(bwlabs, 'Area');
    [~, lblidx] = sort([areas.Area], 'descend');

    % se ci sono più di 10 labels, fai un "pruning"
    if(length(lblidx) > 10)
        lblidx = lblidx(1:10);
    end

    % crea la maschera per l'immagine
    mask = ismember(bwlabs, lblidx);

    figure, imshow(mask);
    saveas(gcf, "./02_polarity_biggestlabels/" + j, 'png');
end