%OPERATORE SPAZIALE: UNA MATRICE DI PESI, CON IL QUALE FACCIO LA
%CONVOLUZIONE=correlazione poichè il filtro è simmetrico
%FILTRO PASSA BASSO: FA PASSARE CIO' CHE NON è UN DETTAGLIO.IL RUMORE/DETTAGLI SONO LE ALTE FREQ.
%TOGLIE I DETTAGLI, FA LO SMOOTH
clear all;
close all;

cat0 = im2double(imread("cat.jpg"));

f5 = fspecial("average", 5);%filtro di media 5x5. ho 25 elem, ogni cella vale 1/25=0.04 -> somma pesi=1
cat5 = imfilter(cat0, f5);

cat11 = imfilter(cat0, fspecial("average", 11));

cat21 = imfilter(cat0, fspecial("average", 21));

%quali informazioni ho perso nello smoothing? faccio la diff

d5 = abs(cat0 - cat5);
d11 = abs(cat0 - cat11);
d21 = abs(cat0 - cat21);

subplot(2, 2, 1), imshow(cat0), title("raw");
subplot(2, 2, 2), imshow(cat5), title("sfocatura con 5x5");
subplot(2, 2, 3), imshow(cat11), title("sfocatura con 11x11");
subplot(2, 2, 4), imshow(cat21), title("sfocatura con 21x21");

figure(2);%imagesc USA I FALSE COLOR PER MOSTARE IL VALORE DEL PIXEL: se la mia pic/matr ha valori tra 0 e 15 lei spalma 
%tra 0 e 255. è tipo una MAP di p5js tra il mio min/max e 0 e 255. non è proprio 255 ma è uguale
subplot(1, 3, 1), imagesc(d5), axis image, colorbar;
subplot(1, 3, 2), imagesc(d11), axis image, colorbar;
subplot(1, 3, 3), imagesc(d21), axis image, colorbar;

%nota che se raw fosse stata una pic monocolore non avrei perso informazion





