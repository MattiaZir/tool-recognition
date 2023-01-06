clear;
close all;
addpath(genpath('support/'));
[images, ~, paths2gt, labels_meaning] = readlists();
n = numel(images); 
%classificatore knn per trovare i pixel di una immagine che sono di obj

train_values=[];
train_labels=[];

for i = 1 : 1: 82
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, [154 205],"nearest"));
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), [154 205],"nearest")>0;    
    gt = uint8(gt);

    [r c ~] = size(im);

    res = compute_local_descriptors(im, 15, 1, @compute_std_dev2);
    
    [rs,cs,ch] = size(res.descriptors); % 12288 x 59 x 1
%     descrittoriAGrandezzaGiusta = reshape(res.descriptors, [res.nt_rows res.nt_cols 1]);
%     descrittoriAGrandezzaGiusta = imresize(descrittoriAGrandezzaGiusta, [r,c], "nearest");
%     descrittoriAGrandezzaGiusta = reshape(descrittoriAGrandezzaGiusta, [], 1);

    train_values = vertcat(train_values, res.descriptors);
    labels_vector = reshape(gt, [r*c 1]); % 12288 x 1 vettore
    train_labels = vertcat(train_labels, labels_vector);

end


[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 

classifier = fitcknn(train_values, train_labels, "NumNeighbors", 3);

cm_all = [];
for i =  1 : 1: n
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, [154 205],"nearest"));
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), [154 205],"nearest")>0;    
    gt = uint8(gt);
    
    [r c ~] = size(im);
    
    res = compute_local_descriptors(im, 15, 1, @compute_std_dev2);
    
    [rs,cs,ch] = size(res.descriptors);

    test.values = res.descriptors;
    labels_vector = reshape(gt, [r*c 1]); % 12288 x 1 vettore

    predicted = predict(classifier, test.values);%vettore di label: 0 e 1 (ho due classi)
        
    p = reshape(predicted, r, c, 1)>0;
    p =imclose(p, strel('disk', 5));
%   figure, show_result(im, p);
    bw = activecontour(im,p,300);
    figure, imshow(bw);

    cm = confmat(logical(labels_vector), reshape(bw, size(predicted)));%confronto predizioni-gtruth
    
    %figure, show_confmat(cm.cm_raw, ["noskin", "skin"]);

    cm_all = [cm_all cm];
end

mean_cm = compute_mean_confmat(cm_all);
%il valore qui sotto è True positive rate (TN è sempre stato alto, il
%problema è che si perdeva gli oggetti!)

%   5x5     ->  0.8726 % OKAY
%   7x7     ->  0.8844 % OKAY
%   10x10   ->  0.8624 % OKAY
%   15x15   ->  0.8254 % OKAY

%pic da 60 a 80 -> 0.1921   (k=3)

%pic da ... a ... -> 0.0448   (k=10) fa schifo k=10 sempre
%pic da 10 a 80 -> 0.3044   k=3
%pic da 81 a 82 -> 0.2306   k=1
%pic da 81 a 82 -> 0.1689   k=3
%pic da 1 a 82  -> 0.3107   k=3
%pic da 1 a 82  ->  0.9800 0.9611  k=1

%da qui in giù testo la predizione sulle pic con + obj
%k=1 5x5 pic multiple   0.2099 %fatto
%k=1 15x15 pic multiple   0.3493 % fatto
%k=1 15x15 imresize=0.2 pic multiple   0.2479
%k=1 15x15 imresize=0.3 pic multiple   0.2065
%k=1 15x15 imresize=0.07 pic multiple   0.3589

%k=3 15x15 imresize=0.2 pic multiple   0.1761

%k=3 15x15 imresize=[150 200] pic multiple   0.4390
%k=3 15x15 imresize=[150 200] +snake e imclose=6 pic multiple  0.9027
%accuracy 0.9025 FATTO
%k=3 15x15 imresize=[150 200] +filtraggio aggressivo +snake e imclose=6 pic multiple accuracy 0.8069
%k=3 15x15 imresize=[150 200] +filtraggio leggero +snake e imclose=6 pic multiple TP 0.8897 accuracy 0.8493
%k=1 15x15 imresize=[150 200] +snake e imclose=6 pic multiple  0.9141 e 
%accuracy 0.8805 ma bordi oggetti sono frastagliati rumorosi

%k=3 5x5 imresize=[150 200] +snake e imclose=6 pic multiple tp=0.9082 accu=0.8961
%k=3 5x5 imresize=[150 200] +snake  pic multiple tp=0.8647 accu=0.9138 però
%non chiude i buchi delle forbici. ma l'obj è rumoroso.


