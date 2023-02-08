close all;
clear all;


baloons = imread('balloons_noisy.png');

%APPLICA IL mediano AI 3 CANALI INDIPENDENTEMENTE

R = baloons(:,:,1);
G = baloons(:,:,2);
B = baloons(:,:,3);


R2 = medfilt2(R, [5 5]);
G2 = medfilt2(G, [5 5]);
B2 = medfilt2(B, [5 5]);

baloons2 = cat(3, R2, G2, B2);
subplot(1,2,1),imshow(baloons);
subplot(1,2,2),imshow(baloons2);

%ora è essenziale fare così ^ per filtrare pic a colori? imfilter è
%intelligente e può farlo lei da sola (l'applicaz del filtro canale per
%canale)