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
    im = rgb2gray(imresize(im, 0.2,"nearest"));
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), 0.2,"nearest")>0;    
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
%TODO imresize fatto bene
accu=[];
for i =  1 : 1: n
    im = im2double(imread(images{i}));
    im = rgb2gray(imresize(im, 0.2,"nearest"));
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), 0.2,"nearest")>0;    
    gt = uint8(gt);
    
    [r c ~] = size(im);
    
    res = compute_local_descriptors(im, 15, 1, @compute_std_dev2);
    
    [rs,cs,ch] = size(res.descriptors);
    
    
    test.values = res.descriptors;
    labels_vector = reshape(gt, [r*c 1]); % 12288 x 1 vettore
    
    
        
    predicted = predict(classifier, test.values);%vettore di label: 0 e 1 (ho due classi)
    
    cm = confmat(labels_vector, predicted);%confronto predizioni-gtruth
%     figure, show_confmat(cm.cm_raw, ["noskin", "skin"]);
    accu= [accu, cm.cm(2,2)];
    
    p = reshape(predicted, r, c, 1)>0;
    p =imclose(p, strel('disk', 6));
%     figure, show_result(im, p);
    bw = activecontour(im,p,300);
    figure, imshow(bw);
end

mean(accu,"all","omitnan")

%   5x5     ->  0.8726
%   7x7     ->  0.8844
%   10x10   ->  0.8624
%   15x15   ->  0.8254

%pic da 60 a 80 -> 0.1921   (k=3)

%pic da ... a ... -> 0.0448   (k=10) fa schifo k=10 sempre
%pic da 10 a 80 -> 0.3044   k=3
%pic da 81 a 82 -> 0.2306   k=1
%pic da 81 a 82 -> 0.1689   k=3
%pic da 1 a 82  -> 0.3107   k=3
%pic da 1 a 82  ->  0.9800 0.9611  k=1

%k=1 5x5 pic multiple   0.2099
%k=1 15x15 pic multiple   0.3493
%k=1 15x15 imresize=0.2 pic multiple   0.2479
%k=1 15x15 imresize=0.3 pic multiple   0.2065
%k=1 15x15 imresize=0.07 pic multiple   0.3589

%k=3 15x15 imresize=0.2 pic multiple   0.1761
