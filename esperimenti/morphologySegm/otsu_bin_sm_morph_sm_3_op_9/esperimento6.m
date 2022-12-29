clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir("./otsu_bin_morph_sm_3_op9");


for j = 1 : 3 : n
    im = im2double(rgb2gray(imread(images{j})));

    se = strel("disk", 3);
    dil = imdilate(im, se);
    er = imerode(im, se);
    bw = imbinarize(dil - er); %% smooth morfologico

    se2 = strel("disk", 9);
    bw_opened = imopen(bw, se2);

    figure("Visible","off"), imshow(bw_opened);

    saveas(gcf, "./otsu_bin_morph_sm_3_op9/" + j, 'png');
end