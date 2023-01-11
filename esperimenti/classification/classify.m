clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images);
load('classifier');

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
        T = extractor(tmp);
        % predictFcn fa la previsione in base alla tabella data
        % predict() vorrebbe invece il classificatore e un array
        obj = trainedModel.predictFcn(T); 

        % proprietà per il labeling sull'immagine
        bBox = [bBox; regionprops(tmp, "BoundingBox").BoundingBox];
        objs = [objs; obj];
    end

    annotated = insertObjectAnnotation(im, 'rectangle', ...
        bBox.*im_res_ratio, objs, "TextBoxOpacity", 0.65, FontSize=12);

    figure, imshow(annotated);
end


