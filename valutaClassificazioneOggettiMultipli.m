clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 
scale_res = [154 205];
similarityPerClasse{13}=42;% in questo cell-array alla posiz i(da 1 fino a 10) c'è una batteria di coeff di jaccard per la classe i

 
for i =  1 : n %test set
    imHD = im2double(imread(images{i}));
    img = rgb2gray(imresize(imHD, scale_res, "nearest"));%opero sull'immagine low-res
    bw = segmentaViaClassificazione(img);
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), scale_res,"nearest");    
    gt = uint8(gt); 


    cc = labelingCompConn(bw);
%     figure(i), imshow(cc);
    [~, ~, immagineLayerOggetti, ~] = classificaOggetti(cc, img, labels_meaning);


%     if(~numel(find(gt==11))==0)
%         figure, imshow(gt==11),title(strcat("gt ", string(i))); %8->di rigetto 9 pappagalli 10 lima 11->pennarello
%     end
%     if(~numel(find(immagineLayerOggetti==11))==0)
%         figure, imshow(immagineLayerOggetti==11), title(strcat("found ", string(i))); %8->di rigetto 9 pappagalli 10 lima 11->pennarello
%     end


    un = unique(gt);
    numClassiVere = numel(un)-1;
    for j= 2:numClassiVere+1 % calcolo la intersec. over union per ogni classe di oggetti
        maskVeraObj = gt== un(j); %magari è tipo: mask con 3 forbici o mask con 1 martello; cioè una mask che ha gli obj di quella classe
%         figure;
%         subplot(1,2,1), imshow(maskVeraObj), title(string(un(j)));
%         subplot(1,2,2), imshow(immagineLayerOggetti==un(j)), title(string(un(j)));
        similarity = jaccard(maskVeraObj, immagineLayerOggetti==un(j));

        similarityPerClasse{un(j)} = [similarityPerClasse{un(j)}, similarity];
    end

end

mediaSimilarityPerClasse=zeros(1,11);
for i = 1:11 
    mediaSimilarityPerClasse(i) = mean(similarityPerClasse{i});
end
figure, bar(mediaSimilarityPerClasse);%la 8 è di rigetto; il coeff di jaccard è zero lì perchè deglio obj da rigettare(classificare come unknown), il classifier non rigetta nessuno
title("(test set) coeff. di jaccard per classe di oggetti");

%la 9=pappa ha coeff zero perchè i due pappa li classifica male(martello)