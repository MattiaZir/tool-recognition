%GAMMA CORRECTION ADATTIVA(cioè non una gamma su tutta la pic ma segmento e
%applico gamme diverse a aree diverse)


clear all;
close all;
im = im2double(imread("contrast.jpg"));%ho una parte sovraesposta ed una sottoesposta

%seleziono una regione rettangolare dell' immagine: righe da 360 a 419 e col da 1 a 505. è
%una sottomatrice!! lo faccio solo per capire quanto sono scuri i pixel lì
%crop = im(360:419, 1:505);
%imshow(crop);
%imhist(crop);

T = 0.2
dark = im <= T;
light = not(dark);

figure(1);
subplot(1, 3, 1), imshow(im), title("raw");
subplot(1, 3, 2), imshow(dark), title("solo pixel scuri(sono ad 1->li vedo bianchi)");
subplot(1, 3, 3), imshow(light), title("solo pixel chiari");


im_dark = im .^ 0.6;
im_light = im .^ 0.9;


out = im_dark .* dark + im_light .* light;%.* dark è per applicare la maschera solo a quei pixel evidenziati dalla mask
figure(2);

subplot(1, 2, 1), imshow(im), title("raw");
subplot(1, 2, 2), imshow(out), title("corretta con 2 gamma diverse");









