clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);

% I RIFLESSI DANNO MOLTI PROBLEMI
for j = 1 : 5
    im = im2double(rgb2gray(imread(strcat("data/",images{j}))));

    % Grandezza arbitraria
    se = strel("disk", ceil(size(im, 1).*0.01));
    opening = imopen(im, se);
    closure = imclose(im, se);
    tophat = im - opening;
    bottomhat = closure - im;

    figure, imshowpair(opening, closure, "montage"), title("opening and closure");
    figure, imshowpair(tophat, bottomhat, "montage"), title("tophat and bottomhat");
end

