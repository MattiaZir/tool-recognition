clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\esperimento_9");


for j = 1 : 3 : n
    im = im2double(imread(images{j}));
    results = ones(size(im, 1), size(im, 2));

    for ch = 1:3
        se = strel("disk", 3);
        dil = imdilate(im(:,:,ch), se);
        er = imerode(im(:,:,ch), se);
        %% dil - er è lo smoothing morfologico
        bw = imbinarize((dil - er), "adaptive", "ForegroundPolarity","dark", "Sensitivity", 0.7);
        bw_opened = imopen(bw, se);
        results = and(results, bw_opened);
    end

    figure("Visible","off"), imshow(results);
    saveas(gcf, "./esperimento_9/" + j, 'png');
end