clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images);
load('classifier');

for i =  1 : n %test set
    im = im2double(imread(images{i}));
    img = rgb2gray(imresize(im, [154 205],"nearest"));
    bw = segmentaViaClassificazione(img);
    cc = labelingCompConn(bw);
    im_res_ratio = size(im, 1:2)/[154 205];

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

    annotated = insertObjectAnnotation(im, 'rectangle', bBox.*im_res_ratio, objs, "TextBoxOpacity", 0.9, FontSize=18);

    figure, imshow(annotated);
end


