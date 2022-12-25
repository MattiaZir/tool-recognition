clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);

for i = 20 : n/5 +25
    im = im2double(rgb2gray(imread(strcat("data/",images{i}))));
    imf = medfilt2(im, [5 5]);
    imf = imfilter(imf, fspecial("gaussian", 7, 1.2));
    imf = imf .^0.5;
%sinceramente sembra meglio senza preprocessing

    bw=1- sauvola(im,[150 150]);

    [L,Centers] = imsegkmeans(uint8(im),2);
    C = double(L==2);


    figure, subplot(1,4,1), imshow(im);
    subplot(1,4,2), imshow(bw);
    subplot(1,4,3), imshow(C);

end
