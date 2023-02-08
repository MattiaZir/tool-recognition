clear all;
close all;

glamor = im2double(imread("glamor.jpg"));
g = fspecial("gaussian", 21, 4);

filtered = imfilter(glamor, g);
subplot(1,3,1), imshow(glamor);
subplot(1,3,2), imshow(filtered);

out = glamor*0.4 +  filtered *(1.4);

subplot(1,3,3), imshow(out);% le parti chiare sono ora più chiare e i dettagli sono stati circa mantenuti