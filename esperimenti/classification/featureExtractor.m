%clear
close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images);
saved_stats = [];


for i =  1 : n %test set
    im = im2double(imread(images{i}));
    img = rgb2gray(imresize(im, [154 205],"nearest"));

    bw = segmentaViaClassificazione(img);
    cc = labelingCompConn(bw);
    %figure, imshow(labeloverlay(img, cc));

    % Calcolo le proprietà delle regioni
    cc_props = regionprops(cc, ["Area", "Perimeter", "BoundingBox", ...
        "EulerNumber", "Centroid"]);
    
    tmp.imPath = images{i}; % path all'immagine originale
    tmp.props = cc_props; % proprietà

    saved_stats = [saved_stats; tmp]; % le accodo ad un array di celle
end

%%
creaTabellaDaRegionProps(saved_stats);
