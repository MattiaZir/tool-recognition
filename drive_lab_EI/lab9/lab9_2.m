close all;
clear all;


im = imread("panda.png")>0;

se = strel("disk", 2);

out_dilate = imdilate(im, se);
imshow(out_dilate);
figure, imshow(out_dilate-im);