clear all;
close all;

gamma = 0.5;

nrg= im2double(imread('nrg.jpg'));
nrg_out = nrg .* gamma; 
subplot(2, 7, 1); imshow(nrg);
subplot(2, 7, 2); imshow(nrg_out);
subplot(2, 7, 2);plot(imhist(nrg));

unequalized= im2double(imread('unequalized.jpg'));
unequalized_out = unequalized .* gamma; 
subplot(2, 7, 3); imshow(unequalized);
subplot(2, 7, 4); imshow(unequalized_out);

contrast= im2double(imread('contrast.jpg'));
contrast_out = contrast .* gamma; 
subplot(2, 7, 5); imshow(contrast);
subplot(2, 7, 6); imshow(contrast_out);