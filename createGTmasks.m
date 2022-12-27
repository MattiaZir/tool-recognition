clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = 20: 22
    im = im2double(rgb2gray(imread(strcat("data/",images{i}))));
    
    bw = 1 - sauvola(im,[150 150]);%strategia migliore
    bw = imclose(bw, strel('disk', 25));
    bw = imopen(bw, strel('disk', 5));

end
