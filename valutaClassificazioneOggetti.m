clear;
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 
scale_res = [154 205];
res_table = [];
cm_all_gt = [];
cm_all_predicted = [];
salva =0;
 
for i =  1 : n %test set
    imHD = im2double(imread(images{i}));
    img = rgb2gray(imresize(imHD, scale_res, "nearest"));%opero sull'immagine low-res
    gt = imread(paths2gt{i});
    gt = imresize(gt(:,:,1), scale_res,"nearest");   
    assert(numel(find(gt==32))==0);

    bw = segmentaViaClassificazione(img);
    cc = labelingCompConn(bw);

    [cetriOggetti, labelsObjs, immagineLayerOggettiTrovati] = classificaOggetti(cc, img, labels_meaning);
    diff = compareMasksV2(gt, immagineLayerOggettiTrovati);%num pixel diversi


    res_table = [res_table; diff/(154*205)];
    

    cm_all_gt =  [cm_all_gt, reshape(gt,[], 1)];
    cm_all_predicted = [cm_all_predicted, reshape(uint8(immagineLayerOggettiTrovati),[], 1)];
end

"media pixel classificati sbagliati:"
1- mean(res_table)

performance = confmat(cm_all_predicted, cm_all_gt)
figure;
show_confmat(performance.cm_raw, performance.labels);


%su 1:n labelT = 0.4;  rapportoAssi,"EulerNumber", "Circularity", "Solidity",  mean(res_table)=0,8829 
%su 1:n labelT = 0.4;  rapportoAssi,"EulerNumber", "Circularity", "Solidity", mediaStdOggetto mean(res_table)=0.8837 
%su 1:n labelT = 0.2;  rapportoAssi,"EulerNumber", "Circularity", "Solidity", mediaStdOggetto mean(res_table)=0.8960

% cm_mean = compute_mean_confmat(cm_all);%fatto per pic binarie!!!
% cm_mean.labels = {'sfondo', 'forbice', 'metro', 'pinza', 'chiave', 'martello', 'cacciavite', 'avvitatore', 'pappagallo', 'lima', 'pennarello', 'sconosciuto'};
% figure, show_confmat(cm_mean.cm_raw, cm_mean.labels);





