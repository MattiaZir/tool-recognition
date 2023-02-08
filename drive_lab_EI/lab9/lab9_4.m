close all;
clear all;


im = im2double(imread("buttons2.png"));

bin = imbinarize(rgb2gray(im), adaptthresh(rgb2gray(im)));
figure, imshow(bin);

%voglio chiudere i 4 buchi interni dei bottoni

noholes = imclose(bin, strel("disk", 9));
figure, imshow(noholes);

%guarda le soluz

%voglio contare i bottoni. voglio avere n reg bianche se nella pic ho n bottoni


