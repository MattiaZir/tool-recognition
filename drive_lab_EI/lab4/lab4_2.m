clear all;
close all;

markers = imread("markers.png");

T = 120/255;
mask = im2bw(markers, T);
imshow(mask);%fa schifo

%il problema di far così(o usare graythresh) è che uso una soglia sola per tutta la pic.

imshow(sauvola(markers, [51 51]));