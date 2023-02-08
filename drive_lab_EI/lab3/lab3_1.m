close all;
clear all;




im = imread('lawrence2.png');

imF = medfilt2(im, [9 9]);


figure(1);
subplot(2,2,1),imshow(im),title('original');

subplot(2,2,2),imshow(imF),title('con mediano 9*9');
