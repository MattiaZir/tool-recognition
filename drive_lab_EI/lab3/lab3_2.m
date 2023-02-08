close all;
clear all;




balls = imread('balls.jpg');

Red = balls(:, :, 1);%tutte le righe tutte le cols del 1o canale
Green = balls(:, :, 2);
Blue = balls(:, :, 3);


figure(1);
subplot(2,3,2), imshow(balls);
subplot(2,3,3+1), imshow(Red);
subplot(2,3,3+2), imshow(Green);
subplot(2,3,3+3), imshow(Blue);

%ORA VOGLIO VEDERE I VARI CANALI(ROSSO, VERDE,BLU) DI COLORE ROSSO, VERDE,
%BLU

onlyRedShown = balls;
onlyRedShown(:,:,2) =0;%metto nel canale G tutti 0
onlyRedShown(:,:,3) =0;%metto nel canale B tutti 0

figure(2);
subplot(1,3,1), imshow(onlyRedShown);




%cat concatena delle matrici(qui 3)
%voglio onlyGreenShown = [ mat 2x2 di 0, Green, mat 2x2]
onlyGreenShown = cat(3, uint8(zeros(size(Green))), Green ,uint8(zeros(size(Green))));
figure(2);
subplot(1,3,2), imshow(onlyGreenShown);






onlyRedShown = cat(3, uint8(zeros(size(balls))), uint8(zeros(size(balls))),uint8(zeros(size(balls))));
onlyBlueShown(:,:,3) =Blue;%metto nel canale B ciò che c'è nella matr di scalari Blue

figure(2);
subplot(1,3,3), imshow(onlyBlueShown);
