clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\01_polarity");


for j = 1 : 9 : n
    im = im2gray(im2double(imread(images{j})));

    thresh = graythresh(im);
    polarity = 'dark';
    
    im = imadjust(im);

    if (thresh > 0.5)
        polarity = 'bright';
    end

    figure, imshow(imbinarize(im, "adaptive", "ForegroundPolarity", polarity, "Sensitivity", thresh));
    saveas(gcf, "./01_polarity/" + j, 'png');
end