clear;
close all;
addpath(genpath('../../support/'));
[images, labels] = readlists();
n = numel(images);

%% TODO: Fare esperimento sui vari metodi di edge detection
for i = 30 : 3 : n
    im = im2double(imread(strcat("data/",images{i})));
    filter = fspecial("average", 5);
    imf = imfilter(im, filter, "replicate"); 
    imf = imsharpen(imf, "Radius", 7, "Amount", 2);
    imedge = zeros(size(imf));

    for i = 1:3
        imedge(:,:,i) = edge(imf(:,:,i), "canny", 0.1);
    end

    imedge2d = imedge(:,:,1) + imedge(:,:,2) + imedge(:,:,3) > 1;
    
    % Utilizzo la morfologia per connettere i bordi
    % SEMBRA FUNZIONARE BENE
    imedge2d = imclose(imedge2d, strel("disk", 15));

    bwlab = bwlabel(imedge2d, 8);

    % Provo a cercare la label con più elementi
    [num, biggest] = max(histcounts(bwlab));

    figure, imshowpair(imf, bwlab == biggest, "montage");



end