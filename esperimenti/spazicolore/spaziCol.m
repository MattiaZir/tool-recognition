close all;
clear all;

im1 = imread('data\0002.jpg');
im2 = imread('data\0033.jpg');

[H1, S1, V1] = rgb2hsv(im1);
[H2, S2, V2] = rgb2hsv(im2);

lab1 = rgb2lab(im1);
lab2 = rgb2lab(im2);

xyz_1 = rgb2xyz(im1);
xyz_2 = rgb2xyz(im2);

ycbcr1 = rgb2ycbcr(im1);
ycbcr2 = rgb2ycbcr(im2);