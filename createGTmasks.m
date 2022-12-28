clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = 41: n
    im = im2double(imread(strcat("data/",images{i})));
    im = im(:,:,1);
    
    bw = 1 - sauvola(im,[150 150]);%strategia migliore
    bw = imclose(bw, strel('disk', 10));
    bw = imopen(bw, strel('disk', 5));
    figure, imshowpair(im, bw, 'montage');
    
end
