clear;
close all;
addpath(genpath('support/'));
[images, dummy, paths2gt, labels_meaning] = readlists();
n = numel(images); 
%classificatore knn per trovare i pixel di una immagine che sono di obj

train.values=[];
train.labels=[];

for i = 1 : 5: 71
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, 0.3));%le mie pic sono in 4/3 altre no
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), 0.3)>0;    

    [r c ~] = size(im);

    res = compute_local_descriptors(im, 20, 10, @compute_lbp);
    
    lbpAGrandezzaGiusta = reshape(res.descriptors, [res.nt_rows res.nt_cols]);%la pic è t_step volte(forse) più piccola di raw
    lbpAGrandezzaGiusta = imresize(lbpAGrandezzaGiusta, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori 
    
    skin = lbpAGrandezzaGiusta .* gt;
    noskin = lbpAGrandezzaGiusta .* (1-gt);
    [rs,cs,ch] = size(skin);
    skin = reshape(skin, rs*cs, ch);
    
    [rns,cns,ch] = size(noskin);
    noskin = reshape(noskin, rns*cns, ch);
    %todo: migliorare efficienza
    train.values = [train.values; noskin; skin];%etichetta 0 a noskin e 1 a skin ---v
    train.labels = uint8([train.labels; zeros(rns*cns, 1); ones(rs*cs, 1)]);%nelle prime n righe ho i dati skin e dopo i noskin

end


%vuole i dati per riga per classificarli
classifier = fitcknn(train.values, train.labels, "NumNeighbors", 3);%k=1 di base 

%lo uso sul test set ora

im = im2double(imread("data/0072.jpg"));
[ri, ci, ch] = size(im);
test.values = reshape( im, ri*ci, ch);

gt = imread(paths2gt{72});
gt = gt(:,:,1) >0;
test.labels = uint8(reshape( gt, ri*ci, 1)) ;

predicted = predict(classifier, test.values);%vettore di label: 0 e 1 (ho due classi)

cm = confmat(test.labels, predicted);%confronto predizioni-gtruth
figure, show_confmat(cm.cm_raw, ["noskin", "skin"]);


p = reshape(predicted, ri, ci, 1)>0;%>0 per il cast in booleani
show_result(im, p);
