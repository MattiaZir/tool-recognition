close all;
clear all;


im = im2double(imread('lanterns.png'));

im1 = rgb2ycbcr(im);
%DI IM1 VOGLIO BLURRARE SOLO LA Y e mostare il risultato(cast in rgb necessario)
%DI IM2 VOGLIO BLURRARE SOLO LA Cr e mostare il risultato(cast in rgb necessario)

im2 = im1;

GF = fspecial("gaussian", 33, 6);

im1(:,:,1) = imfilter(im1(:,:,1), GF);

im2(:,:,3) = imfilter(im2(:,:,3), GF);

out1 = ycbcr2rgb(im1);
out2 = ycbcr2rgb(im2);
subplot(1,3,1), imshow(im), title("RAW");
subplot(1,3,2), imshow(out1), title("y filtrato");%IL GAUSSIANO SULLA Y è PER NOI EVIDENTISSIMO
subplot(1,3,3), imshow(out2), title("cr filtrato");%IL BLUR SUL CROMA NON LO NOTO NEMMENO


