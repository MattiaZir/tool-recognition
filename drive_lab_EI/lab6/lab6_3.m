%classificatore beyesiano per trovare i pixel di una immagine che sono di pelle
clear all;
close all;

skin = im2double(imread("skin.png"));
[rs,cs,ch] = size(skin);
skin = reshape(skin, rs*cs, ch);
noskin = im2double(imread("noskin.png"));
[rns,cns,ch] = size(noskin);
noskin = reshape(noskin, rns*cns, ch);

train.values = [noskin; skin];%etichetta 0 a noskin e 1 a skin
train.labels = uint8([zeros(rns*cns, 1); ones(rs*cs, 1)]);%nelle prime n righe ho i dati skin e dopo i noskin

%vuole i dati per riga per classificarli
classifier = fitcnb(train.values, train.labels);%allena il class

%lo uso sul test set ora

im = im2double(imread("test1.jpg"));
[ri, ci, ch] = size(im);
test.values = reshape( im, ri*ci, ch);


gt = imread("test1-gt.png");% fatta da zeri(0) e uni(1)
test.labels = uint8(reshape( gt, ri*ci, 1));

predicted = predict(classifier, test.values);%vettore di label: 0 e 1 (ho due classi)

cm = confmat(test.labels, predicted);%confronto predizioni-gtruth
figure, show_confmat(cm.cm_raw, ["noskin", "skin"]);


p = reshape(predicted, ri, ci, 1)>0;%>0 per il cast in booleani
show_result(im, p);



