clear all;
close all;


horse= imread('horse.jpg');
horse_hist = imhist(horse);%conta le occorrenze di quel tono, è un array di 255. E.g. imhist[0]=123 -> 123 pixel sono a 0
subplot(1, 7, 1); plot(horse_hist);

family= imread('family.jpg');
family_hist = imhist(family);
subplot(1, 7, 2); plot(family_hist);

nrg= imread('nrg.jpg');
nrg_hist = imhist(nrg);
subplot(1, 7, 3); plot(nrg_hist);

nrg_eq = histeq(nrg);
subplot(1, 7, 4); imshow(nrg);title("Prima");
subplot(1, 7, 5); imshow(nrg_eq);title("Dopo");

family_eq = histeq(family);
subplot(1, 7, 6); imshow(family);title("Prima");
subplot(1, 7, 7); imshow(family_eq);title("Dopo");