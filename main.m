clear;
close all;
addpath(genpath('support/'));
[images, l, labels_meaning] = readlists('multiple');
n = numel(images);

for i = 1:n
    im = im2double(rgb2gray(imread(images{i})));    
    im = medfilt2(im, [10 10]);
    im = imfilter(im, fspecial("gaussian", 10, 1.8));

    [r c ch] = size(im);
    
    res = compute_local_descriptors(im, 30, 15, @compute_lbp);%prima era 30 15
    
    labels = kmeans(res.descriptors, 2);
    counts = histcounts(labels);


    labels_image = reshape(labels, [res.nt_rows res.nt_cols]);%la pic della label è 5 volte più piccola di raw
    labels_image = imresize(labels_image, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori di labels
    
    if(counts(1)>counts(2)) %cerco classe + numerosa (lo sfondo)
        bw = labels_image==2;
    else 
        bw = labels_image==1;
    end

    figure,subplot(1,2,1), imshow(bw);
    bw = imclose(bw, strel('disk',5));
    bw = imopen(bw, strel('disk',10));
    bw = imclose(bw, strel('disk',20));
    subplot(1,2,2), imshow(bw);

end
