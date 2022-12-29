clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\otsu_bin_sm_morph_3");


for j = 1 : 3 : n
    im = im2double(rgb2gray(imread(images{j})));

    se = strel("disk", 3);
    dil = imdilate(im, se);
    er = imerode(im, se);
    bw = imbinarize(dil - er); %% smooth morfologico

    figure("Visible","off"), imshow(bw);

    saveas(gcf, "./otsu_bin_sm_morph_3/" + j, 'png');
end