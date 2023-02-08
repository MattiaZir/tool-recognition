close all;
clear all;

im = im2double(imread("face-noisy.png"));

GF = fspecial("gaussian", 7, 1.2);

blurred = imfilter(im, GF);
diff = im - blurred;
diff = 2*diff;%superfluo, accentuo
unsharpened = im + diff;
figure, imshow(im);
figure, imshow(diff);
figure, imshow(unsharpened);