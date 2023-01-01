clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\adaptive_sm_3_op_3");


for j = 1 : 3 : n
    im = im2double(rgb2gray(imread(images{j})));

    se = strel("disk", 3);
    dil = imdilate(im, se);
    er = imerode(im, se);
    %% dil - er è lo smoothing morfologico
    bw = imbinarize((dil - er), "adaptive", "ForegroundPolarity","dark", "Sensitivity", 0.7);

    bw_opened = imopen(bw, se);
    figure("Visible","off"), imshow(bw);
    saveas(gcf, "./adaptive_sm_3_op_3/" + j, 'png');
end