clear all;
close all;

hand = imread("hand1.jpg");

%plot(imhist(hand));

T = 35/255;%soglia con cui binarizzo, scelta  a manina
mask = im2bw(hand, T);%pic binaria ottenuta sogliando

mask = medfilt2(mask, [7 7]);%uso il mediano per fa sparire i pixel neri tra i bianchi e i bianchi tra i neri

figure, subplot(1,2,1), imshow(hand);
 subplot(1,2,2), imshow(mask);
 
T2 = graythresh(hand);%funz magica che stima la soglia ideale per binarizzare pic bianco e nero bimodali, in realtà fa schifo
%e poi faccio quel che ho fatto sopra


%per binarizzare automaticamente prima di tutto applico la gamma per far
%allontanare i valori alti(i bianchi) dai neri.

%poi magari uso (per la soglia) graythresh(algo di otsu) e lo moltiplico per 0.8 o comunque
%un valore che metto io