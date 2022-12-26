clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = 39: 39
    im = im2double(rgb2gray(imread(strcat("data/",images{i}))));
    
    bw = 1 - sauvola(im,[150 150]);%strategia migliore
    bw = imclose(bw, strel('disk', 20));
    bw = imopen(bw, strel('disk', 5));
    figure, imshow(bw);
end
