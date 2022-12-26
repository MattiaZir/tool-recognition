clear;
close all;

im = imread('../../data/0040.jpg');
[A, B] = Ms2(im, 0.25);
A = im2gray(A);

imshow(A);
B;
