clear;
close all;
addpath(genpath('support/'));
[images, dummy, paths2gt, labels_meaning] = readlists();
n = numel(images); 


for i = n-15 : n % solo 1 pic ha la gt quindi... 1:1 e non 1:n
    im = imread(images{i});
    im = imresize(im, [768, 1024]);%le mie pic sono in 4/3 altre no
    im = im2double(rgb2gray(im));
    im = medfilt2(im, [10 10]);
    im = medfilt2(im, [10 10]);
    im = medfilt2(im, [10 10]);
    im = medfilt2(im, [10 10]);
    im = medfilt2(im, [10 10]);
    im = imfilter(im, fspecial("gaussian", 10, 1.8));
    im = imfilter(im, fspecial("gaussian", 10, 1.8));
    im = imfilter(im, fspecial("gaussian", 10, 1.8));
    im = imfilter(im, fspecial("gaussian", 10, 1.8));
    im = imfilter(im, fspecial("gaussian", 10, 1.8));
 
    
%     figure, imshow(im);
    bw = segmenta(im);
    
%     figure, imshow(bw);

    edg = edge(im, 'sobel');

    figure, imshow(edg);%gli edge li trova giusti, ma come sfruttare questa info?
    edg = imdilate(edg, strel('disk', 30));
    im2 = im .* edg;

%     figure, imshow(im2);

%     figure, imshow(im);
%     bw = imopen(bw, strel('disk',5));
%     bw = imclose(bw, strel('disk',10));
    

%     L = labelingCompConn(bw);
%     figure, imagesc(L), title("labellata");


end