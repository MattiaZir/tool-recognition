close all;
clear all;


im = im2double(imread("coins.png"));

bin = 1- imbinarize(im, 0.8);
figure, imshow(bin);

out = imclose(bin, strel("disk", 9));
figure, imshow(out);%cerchi pieni perfetti ora
%voglio togliere il rumore nella segmentaz senza che le dim delle reg siano
%mantenute

%faccio erosion e dilate

