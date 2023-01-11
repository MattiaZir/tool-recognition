clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images);
load('classifier');

for i =  1 : n %test set
    im = im2double(imresize(imread(images{i}), [154*4 205*4]));
    img = rgb2gray(imresize(im, [154 205],"nearest"));
    %bw = segmentaViaClassificazione(img);
    bw = imread(paths2gt{i}) > 0;
    bw = imresize(bw, [154 205]);
    cc = labelingCompConn(bw);
    im_res_ratio = 4;

    cc_unique = unique(cc);

    bBox = [];
    objs = [];
    for k = 2:length(cc_unique) % parte da 2 perché 1 corrisponde allo sfondo
        tmp = ismember(cc, cc_unique(k));
        T = extractor(tmp);
        obj = trainedModel.predictFcn(T);

        bBox = [bBox; regionprops(tmp, "BoundingBox").BoundingBox];
        objs = [objs; obj];
    end

    annotated = insertObjectAnnotation(im, 'rectangle', bBox.*im_res_ratio, objs, "TextBoxOpacity", 0.9, FontSize=12);

    figure, imshow(annotated);
end


