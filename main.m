clear;
close all;

[images, l] = readlists();
n = numel(images);

for j = 1 : n/2
    im = im2double(rgb2gray(imread(strcat("Progetto/data/",images{j}))));

    
    %qui ci metto chi ho scelto come migliore
end

