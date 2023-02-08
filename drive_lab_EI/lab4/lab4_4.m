clear all;
close all;

signs = rgb2ycbcr(imread("signs.jpg"));

firstChannel = signs(:, :, 1);
secondChannel = signs(:, :, 2);
thirdChannel = signs(:, :, 3);
subplot(3,4,1), plot(imhist(firstChannel));
subplot(3,4,2), plot(imhist(secondChannel));
subplot(3,4,3), plot(imhist(thirdChannel));
subplot(3,4,1+3), imshow(firstChannel);
subplot(3,4,2+3), imshow(secondChannel);
subplot(3,4,3+3), imshow(thirdChannel);
%noto che nel canale cb vedo a valore alto i cartelli verdi e nel cb a val
%bassi i cartelli blu
maskBlu = im2bw(secondChannel, 160/255)
subplot(3,4,2+6), imshow(maskBlu);
maskVerde = im2bw((255-thirdChannel), 178/255);
subplot(3,4,3+6), imshow(maskVerde);

mask = uint8( maskBlu + maskVerde );

imshow(mask);
imshow(mask .* im2double(signs(:, :, 1)));%o circa