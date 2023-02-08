%classificatore a minima distanza per trovare i pixel di una immagine che sono di pelle
clear all;
close all;

im = im2double(imread("test1.jpg"));
skin = im2double(imread("skin.png"));
noskin = im2double(imread("noskin.png"));

[r,c,ch]=size(skin);
pixs = reshape(skin, r*c, ch);
ms = mean(pixs);

[r,c,ch]=size(noskin);
pixs = reshape(noskin, r*c, ch);
mns = mean(pixs);

[r,c,ch]=size(im);
pixs = reshape(im, r*c, ch);
%potrei usare due for ma uso pdist: fa le distanze di tutti gli elem cartesiano elem

dist_s = pdist2(pixs, ms);%array di distanzE di ogni pixel dal modello di skin
dist_ns = pdist2(pixs, mns);%array di distanzE di ogni pixel dal modello di nonskin

predicted = dist_s < dist_ns;%pixel(elem)-wise. 1 sse la dist del colore del pixel dal modello di skin è < dalla dist del modello di nonskin

predicted = reshape(predicted, r, c, 1);

cm = confmat(pixs, predicted);

figure, show_confmat(cm.cm_raw, ["noskin", "skin"]);





