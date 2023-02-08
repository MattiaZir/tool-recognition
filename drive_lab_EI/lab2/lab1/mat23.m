clear all;
close all;

moon= imread('moon.jpg');
clouds= imread('clouds.jpg');
figure(1);
%imshow(moon);

%cloudsResized = imresize(clouds,[size(moon, 1), size(moon, 2)]); %imresize(A,[numrows numcols]) riscala la pic A a grandezza numrows x numcols

cloudsResized = imresize(clouds, size(moon));

ims = im2double(moon) + im2double(cloudsResized);
subplot(1, 7, 1); imshow(ims);

imd = im2double(cloudsResized) -im2double(moon);
subplot(1, 7, 2); imshow(imd);

traspNubi = 0.8 % tra 0 e 1 : 0 -> non vedo nubi; 1-> vedo solo loro
imCombined = traspNubi * im2double(cloudsResized) + (1-traspNubi)* im2double(moon);
% anche con ^ dove le due figure si sovrappongono ottengo molto bianco
% perchè i valori si sovrappongono e sommano. in questa regione abbiamo o solo pixel di nuvole o solo pixel di luna 
%spegnendo gli altri pixel.

mask_clouds= (im2double(cloudsResized)>0.3);% mette a 1 solo i pixel che sono > soglia;gli altri a 0; è un classificatore idealmente
subplot(1, 7, 3); imshow(mask_clouds);
moonMenoClouds = im2double(moon) .* (1-mask_clouds); %. è per dire prodotto pixelWise (senza fa il prodotto tra matrici) 
subplot(1, 7, 4); imshow(moonMenoClouds);
out =  moonMenoClouds + im2double(cloudsResized); %combino le pic ora senza aree comuni
subplot(1, 7, 5); imshow(out);






