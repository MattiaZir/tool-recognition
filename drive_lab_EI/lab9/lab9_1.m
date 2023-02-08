close all;
clear all;


im = imread("disney.png");

se = strel("square", 3);

out_dilate = imdilate(im, se);

for i = 1:4
    out_dilate = imdilate(out_dilate, se);%itero la dilate
end




se2 = strel("square", 3+2*5);

out = imdilate(im, se2);

figure, imshowpair(out_dilate, out, 'montage');%è uguale iterare la dilate o farne una + grande
