close all;
clear all;


I = rgb2gray(im2double(imread('mondrian.jpg')));

BW1 = edge(I,'prewitt');
BW2 = edge(I,'canny');
figure, imshow(BW1)
figure, imshow(BW2)