clear;
close all;
addpath(genpath('support/'));
[images, labels] = readlists();
n = numel(images);
r=2;c=3;
%sinceramente sembra meglio senza preprocessing

for i = 1: n/2
    im = im2double(rgb2gray(imread(strcat("data/",images{i}))));

%senza filtraggio:
    bw = 1 - sauvola(im,[150 150]);

    [L,Centers] = imsegkmeans(uint8(im),2);
    C = double(L==2);

    adp=1-imbinarize(im,adaptthresh(im,0.5,"ForegroundPolarity","dark"));

    figure, title("(con closing usando SE circolare raggio 25)");
    subplot(r,c,1),imshow(imclose(bw, strel('disk', 25))), title("sauvola");
    subplot(r,c,2), imshow(imclose(C, strel('disk', 25))), title("kmeans");
    subplot(r,c,3), imshow(imclose(adp, strel('disk', 25))), title("adaptive");

%con filtraggio:

    imf = medfilt2(im, [5 5]);
    imf = imfilter(imf, fspecial("gaussian", 7, 1.2));

    bw = 1 - sauvola(imf,[150 150]);

    [L,Centers] = imsegkmeans(uint8(imf),2);
    C = double(L==2);

    adp=1-imbinarize(imf,adaptthresh(imf,0.5,"ForegroundPolarity","dark"));

    subplot(r,c,1+c),imshow(imclose(bw, strel('disk', 25))), title("filtraggio+sauvola", "FontSize",8);
    subplot(r,c,2+c), imshow(imclose(C, strel('disk', 25))), title("filtraggio+kmeans", "FontSize",8);
    subplot(r,c,3+c), imshow(imclose(adp, strel('disk', 25))), title("filtraggio+adaptive", "FontSize",8);



end
