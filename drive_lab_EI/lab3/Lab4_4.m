close all;
clear all;




face = im2double(imread('face-noisy.png'));

%APPLICA IL GAUSSIANO AI 3 CANALI INDIPENDENTEMENTE

R = face(:,:,1);
G = face(:,:,2);
B = face(:,:,3);

GF = fspecial("gaussian", 7, 1.2);

R2 = imfilter(R, GF);
G2 = imfilter(G, GF);
B2 = imfilter(B, GF);

face2 = cat(3, R2, G2, B2);
imshow(face2);

%ora è essenziale fare così ^ per filtrare pic a colori? imfilter è
%intelligente e può farlo lei da sola (l'applicaz del filtro canale per
%canale)