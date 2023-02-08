clear all;
close all;

im1 = im2double(imread("lawrence1.png"));%pic con rumore gaussiano
im2 = im2double(imread("lawrence2.png"));%pic con rumore salt e pepper

im1Filtrata = imfilter(im1, fspecial("gaussian", 5, 1));

im2Filtrata = imfilter(im2, fspecial("gaussian", 5, 1));


subplot(2, 2, 1), imshow(im1), title("raw1");
subplot(2, 2, 3), imshow(im1Filtrata), title("im1Filtrata");
subplot(2, 2, 2), imshow(im2), title("raw2");
subplot(2, 2, 4), imshow(im2Filtrata), title("im2Filtrata");



