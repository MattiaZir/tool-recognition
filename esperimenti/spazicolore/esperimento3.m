clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\03_hsv_eq");


for j = 1 : 9 : n
    im = im2double(imread(images{j}));

    [H, S, V] = rgb2hsv(im); % ci serve dopo per moltiplicare le maschere
    figure, imshow(imadjust(S));


    % TROVO IL PICCO nella S
    [~, satVal] = max(imhist(S));
    satVal = satVal/256;

    % trova i 95-esimi percentili
    percentileS = [satVal * 0.95, satVal + (satVal * 0.95)];

    % Binarizza le due immagini nell'intervallo di prima
    bwS = and(S > percentileS(1), S < percentileS(2));

    outis = {im bwS (im.*bwS)};
    
    figure("Visible","off"), montage(outis, Size=[1 3]);
    saveas(gcf, "./03_hsv_eq/" + j, 'png');
end