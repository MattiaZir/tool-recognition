clear all;
close all;

cat0 = im2double(imread("cat.jpg"));

f5 = fspecial('gaussian',5, 1) %filtro di gaussiano 5x5 con sigma=grandezza campana=2o param. è di smoothing 
catGass = imfilter(cat0, f5);
subplot(1,2,1), imshow(cat0);
subplot(1,2,2), imshow(catGass);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           