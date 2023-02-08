close all;
clear all;




building = imread('building.jpg');


building2 = rgb2hsv(building);
%imshow(building2); IMSHOW SUPPONE CHE IL SUO PARAM SIA DA INTERPRETARE
%COME PIC RGB



Y = building2(:, :, 1);%tutte le righe tutte le cols del 1o canale
Cb = building2(:, :, 2);
Cr = building2(:, :, 3);


figure(1);
subplot(2,3,1), imshow(Y);
subplot(2,3,2), imshow(Cb);
subplot(2,3,3), imshow(Cr);