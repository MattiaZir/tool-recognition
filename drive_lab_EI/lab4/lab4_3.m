clear all;
close all;

hand2 = imread("hand2.jpg");%è a colori!!!
%provo a portarla in scala di grigi per segmantare(binarizzare),ma esce
%male... non è mica la soluzione a tutti i mali fare così eh...
gray = rgb2gray(hand2);
imshow(gray);
T = graythresh(gray),
mask = im2bw(gray, T);
subplot(2, 2, 1), imshow(mask);%esce male

%allora provo a lavorare su un solo colre della pic raw...
onlyRedInBN = hand2(:, :, 1);
T1 = graythresh(onlyRedInBN);
mask1 = im2bw(gray, T1);
subplot(2, 2, 2), imshow(mask1);%schifo uguale


%devo isolare la luminanza y e non considerarla. considero solo cb o cr
%andrebbe anche bene hSv considerando la saturaz
ycbcr = rgb2ycbcr(hand2);
cr = ycbcr(:, :, 3);
imhist(cr);
T2 = graythresh(cr),
mask2 = im2bw(cr, T2);
subplot(2, 2,3), imshow(mask2);
