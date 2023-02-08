%se non termino i comandi con ; voglio vedere il loro risulato stampato nella comm window

clear all; %svuoto il workspace da eventuali var lasciate da altri script. non chiude le finestre che lo script apre con figure
close all;%chiude le finestre aperte


img1 = imread("optical.jpg");

%potrei fare un for che pixel per pixel fa s= 255-r oppure più sisteticamente

img2 = 255 - img1; %lui internamente una matr fatta da [255,255,...,255] e la sottrae alla matr che è img1

%imshow(img1)
%imshow(img2)
figure(1);%gli dò un indice così è chiaro come si chiama la figure. posso richiamare una figure x dalla command window con figure(x)

%i comandi plot/show ecc si applicano alla figure attiva ora

subplot(2, 5, 1);%figure fatta da 1 riga 2 cols; la prima cella è quella attiva ora
imshow(img1); title("imm positiva"); %title va dopo imshow non prima
subplot(2, 5, 2); 
imshow(img2); title("imm negativa");
%IL TERZO PARAM DELLA SUBPLOT è L'INDICE NELLA MATRICE, NON INDICE DI RIGA
%COLONNA
subplot(2, 5, 4+5*1);imshow(img1);%INDEX = 4+5*1 è  4o elem sulla riga 1
%è meglio operare sempre con pic rappresentate come double, perchè in uint8(di base), è facile uscire dal range (0,255)
% -1 se opero in uint8 viene clippato a 0; come 400 viene clippato a 255;
% se opero con le pic in double ^ informazioni non le perdo!!lui non
% clippa!