clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = floor(3* n/4) : floor(n)
    im = im2double(rgb2gray(imread(strcat("data/",images{i}))));
    
    bw= 1 - sauvola(imf,[150 150]);%strategia migliore

end
