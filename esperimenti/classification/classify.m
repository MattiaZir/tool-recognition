clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images);
load('classifier');
% Preferirei aggiungere delle classi di "no object" piuttosto che usare
% una percentuale del genere, però meglio di nulla
labelT = 0.85; % threshold dell'oggetto, se è < del valore, è "unknown"

% Questa è da generalizzare, così da inserire direttamente nel main
% inoltre sarebbe utile cercare di migliorare la segmentazione e magari
% aggiungere non-tools al dataset.
for i =  1 : n %test set
    % faccio un resize a 4 volte la grandezza più piccola, così
    % quando metto le annotazioni l'immagine non è microscopica e sgranata
    im_res_ratio = 4; % di quanto ingrandire l'immagine
    im = im2double(imresize(imread(images{i}), [154*im_res_ratio 205*im_res_ratio]));
    img = rgb2gray(imresize(im, [154 205],"nearest"));
    bw = segmentaViaClassificazione(img);
    cc = labelingCompConn(bw);

    cc_unique = unique(cc);

    bBox = [];
    objs = [];
    for k = 2:length(cc_unique) % parte da 2 perché 1 corrisponde allo sfondo
        tmp = ismember(cc, cc_unique(k)); % prende solo una delle regioni
        T = splitvars(extractor(tmp)); %splitto gli hu_moments per dopo

        mdl = objClassifier.ClassificationTree;
        [label, prob] = predict(objClassifier.ClassificationTree, splitvars(T));
        maxProb = max(prob);
        
        if(maxProb < labelT)
            label = sprintf("unknown %0.1f%%", maxProb*100);
        else
            label = sprintf("%s %0.1f%%", label{1}, maxProb*100);
        end
        
        % proprietà per il labeling sull'immagine
        bBox = [bBox; regionprops(tmp, "BoundingBox").BoundingBox];
        objs = [objs; label];
    end

    annotated = insertObjectAnnotation(im, 'rectangle', ...
        bBox.*im_res_ratio, objs, "TextBoxOpacity", 0.65, FontSize=12);

    figure, imshow(annotated);
end


