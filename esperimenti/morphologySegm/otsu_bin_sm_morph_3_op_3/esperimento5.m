clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\otsu_bin_sm_morph_sm_3_op3");


for j = 1 : 3 : n
    im = im2double(rgb2gray(imread(images{j})));

    se = strel("disk", 3);
    dil = imdilate(im, se);
    er = imerode(im, se);
    bw = imbinarize(dil - er); %% smooth morfologico

    bw_opened = imopen(bw, se);

    figure("Visible","off"), imshow(bw_opened);

    saveas(gcf, "./otsu_bin_sm_morph_sm_3_op3/" + j, 'png');
end