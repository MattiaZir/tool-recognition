clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists();
n = numel(images); 
scale_res = [154 205];
cm_all_gt = [];
cm_all_predicted = [];
 
for i =  1 :n %test set
    imHD = im2double(imread(images{i}));
    img = rgb2gray(imresize(imHD, scale_res, "nearest"));%opero sull'immagine low-res
    bw = segmentaViaClassificazione(img);
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), scale_res,"nearest")>0;    
    gt = uint8(gt); 

    cc = labelingCompConn(bw);
%     figure(i), imshow(cc);
    [~, labelsObjs, ~, ~] = classificaOggetti(cc, img, labels_meaning);
    

    if numel(labelsObjs) == 1 % se è zero, 2, 3, ... classi predette; ma dovrebbe essere 1
                
        labelsObjs = (labelsObjs);% sennò la append di sotto fatta con [ ] concatena le stringhe in una sola!    
    
        cm_all_gt =  [cm_all_gt, symbolicLabels(i)];
        cm_all_predicted = [cm_all_predicted, labelsObjs(1)];
    end
end


performance = confmat(cm_all_predicted, cm_all_gt)
figure;
show_confmat(performance.cm_raw, performance.labels);





