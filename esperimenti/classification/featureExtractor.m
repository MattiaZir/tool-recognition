clear

%features:
% area/2p^2 % fatto
% rapporto assi BB % fatto
% rettangolarità %fatto
% num di eulero %fatto
% momenti %da fare
% albero concavità(difficile) %da fare
% signature outer bound % da fare

close all;
addpath(genpath('support/'));
[images, symbolicLabels, paths2gt, labels_meaning] = readlists();
n = numel(images);
saved_stats = [];



for i =  1 : n %test set
    im = im2double(imread(images{i}));
    img = rgb2gray(imresize(im, [154 205],"nearest"));
    bw = imread(paths2gt{i}) > 0;
    bw = imresize(bw, [154 205]);
    
    
    cc = labelingCompConn(bw);
    %figure, imshow(labeloverlay(img, cc));

    % Calcolo le proprietà delle regioni
    cc_props = regionprops(cc, ["Area", "Perimeter", "BoundingBox", ...
        "EulerNumber", "Centroid", "Eccentricity", "Circularity", "Solidity"] ...
        "");
    
    if(length(unique(cc)) > 1) % se è solo nera non inserirla nemmeno
        tmp.imPath = images{i}; % path all'immagine originale
        tmp.props = cc_props; % proprietà
        tmp.label = string(symbolicLabels{i, 1});
        tmp.moments = hu_moments(cc, cc_props.Centroid);
    
        saved_stats = [saved_stats; tmp];
    end
end

%%
T = creaTabellaDaRegionProps(saved_stats);
