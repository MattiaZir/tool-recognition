clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\01_cielab");


for j = 1 : 9 : n
    im = im2double(imread(images{j}));
    
    imlab = rgb2lab(im); % ci serve dopo per moltiplicare le maschere
    imlabgray = mat2gray(imlab); % riporta i valori tra 0 e 1
    labNoL.a = imlabgray(:,:,2);
    labNoL.b = imlabgray(:,:,3);

    
    % TROVO IL PICCO nei due istogrammi
    [~, labNoL.aMaxBin] = max(imhist(labNoL.a));
    [~, labNoL.bMaxBin] = max(imhist(labNoL.b));

    % trova i 95-esimi percentili (e normalizza)
    percentileA = ceil([labNoL.aMaxBin * 0.95, labNoL.aMaxBin + (labNoL.aMaxBin * 0.95)] )./256;
    percentileB = ceil([labNoL.bMaxBin * 0.95, labNoL.bMaxBin + (labNoL.aMaxBin * 0.95)] )./256;

    % Binarizza le due immagini nell'intervallo di prima
    bwA = and(labNoL.a > percentileA(1), labNoL.a < percentileA(2));
    bwB = and(labNoL.b > percentileB(1), labNoL.b < percentileB(2));
    
    % combina la maschera
    combined = bwA + bwB > 0;
    outis = {im bwA bwB combined (im.*combined)};
    
    figure("Visible","off"), montage(outis, Size=[1 5]);
    saveas(gcf, "./01_cielab/" + j, 'png');
end