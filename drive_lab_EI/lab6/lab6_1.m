%classificatore a parallelepipedo per trovare i pixel di una immagine che sono di pelle

clear all;
close all;

im = im2double(imread("test1.jpg"));
skin = im2double(imread("skin.png"));

[r, c, ch] = size(skin);%ch sarà 3

pixs = reshape(skin, r*c, ch);%495000 righe 3colonne, una per canale colore

%mean ed std lavorano colonna per colonna
m= mean(pixs);%[0.833057627252687,0.662523279857298,0.585166480491144]
% rosso verde blu dello skin medio
v=std(pixs);%varinza dallo skin medio. per i 3 canali colore.

k=1;%coeff utile che sia qui per allargare/restringere le maglie velocemente


%CLASSIFICATORE A PARALLELEPIPEDO
%MAPPO COME SKIN CIò CHE STA NELL'INTORNO DELLA MEDIA DELLA SKIN VISTA NEL
%TRAINING SET(SKIN.PNG)
mr= (im(:,:,1) <= m(1) + k*v(1)) & (im(:,:,1) >= m(1) - k*v(1));
mg= (im(:,:,2) <= m(2) + k*v(2)) & (im(:,:,2) >= m(2) - k*v(2));
mb= (im(:,:,3) <= m(3) + k*v(3)) & (im(:,:,3) >= m(3) - k*v(3));

predicted = mr & mg & mb;

gt = imread("test1-gt.png")>0;%legge o 0 o 1 dalla pic .... ma sono int! 0>0 -> 0 booleano 1>0 -> 1 booleano

cm = confmat(gt, predicted);%matrice di confuzione(dati assoluti)
%   (1,1) trovo il valore dei true negative e in (2,2) i true positive
%in (1, 2) ho i false positive e in (2,1) i false negative
%cm.cm riporta il dato relativo. cm.accuracy è poco significativo perchè la
% la classe non pelle è di gran lunga più presente e dominante. dato che
% con la nonskin classifico bene sembra che classifiche bene tutto. la
%ciocca ci lascia lo script show_confmap.m per mostrare una c map più bella

%con k=1 imbrocca il 33% di skin classificandola come skin
show_result(im, predicted);

figure, show_confmat(cm.cm_raw, ["noskin", "skin"]);

  
