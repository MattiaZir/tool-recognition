clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for j = 1 : n
    im = im2double(rgb2gray(imread(strcat("data/",images{j}))));
    
    
    %qui ci metto chi ho scelto come migliore
end
