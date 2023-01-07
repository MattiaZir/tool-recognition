clear
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
    figure, imshow(labeloverlay(img, cc));

    % Calcolo le proprietà delle regioni
    cc_props = regionprops(cc, ["Area", "Perimeter", "BoundingBox", "EulerNumber", "Centroid"]);
    
    tmp.imPath = images{i}; % path all'immagine originale
    tmp.props = cc_props; % proprietà

    saved_stats = [saved_stats; tmp]; % le accodo ad un array di celle
end

%%
counter = 1;
for k = 1:length(saved_stats)
    curr = saved_stats(k);
    
    for lab = 1:length(curr.props)
        T(counter).imPath = string(curr.imPath);
        T(counter).label = lab;
        T(counter).Area = curr.props(lab).Area;
        T(counter).Perimeter = curr.props(lab).Perimeter;
        T(counter).Centroid_x = curr.props(lab).Centroid(1, 1);
        T(counter).Centroid_y = curr.props(lab).Centroid(1,2);
        T(counter).EulerNumber = curr.props(lab).EulerNumber;
        T(counter).BBox_x = curr.props(lab).BoundingBox(1,1);
        T(counter).BBox_y = curr.props(lab).BoundingBox(1,2);
        T(counter).BBox_width = curr.props(lab).BoundingBox(1,3);
        T(counter).BBox_height = curr.props(lab).BoundingBox(1,4);
        T(counter).APSquared = curr.props(lab).Area/(curr.props(lab).Perimeter^2);

        counter = counter + 1;
    end
end

T = struct2table(T);
