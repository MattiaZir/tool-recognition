clear;
close all;
addpath(genpath('support/'));
[images, dummy, paths2gt, labels_meaning] = readlists('multiple');
n = numel(images); 


for i = 1 : 1 % solo 1 pic ha la gt quindi... 1:1 e non 1:n
    im = imread(images{i});
    im = imresize(im, [384, 512]);
    im = im2double(rgb2gray(im));
    im = medfilt2(im, [10 10]);
    im = imfilter(im, fspecial("gaussian", 10, 1.8));

    [r c ch] = size(im);

    res = compute_local_descriptors(im, 30, 15, @compute_lbp);%prima era 30 15

    labels = kmeans(res.descriptors, 2); %Rows of 1st argument correspond to points and columns correspond to variables. 
    counts = histcounts(labels);


    labels_image = reshape(labels, [res.nt_rows res.nt_cols]);%la pic della label è 5 volte più piccola di raw
    labels_image = imresize(labels_image, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori di labels

    if(counts(1)>counts(2)) %cerco classe + numerosa (lo sfondo)
        bw = labels_image==2;
    else
        bw = labels_image==1;
    end


    figure,subplot(1,3,1), imshow(im);
    bw = imopen(bw, strel('disk',5));
    bw = imclose(bw, strel('disk',20));
    subplot(1,3,2), imshow(bw);
    


    [L,N] = bwlabel(bw,8);
    numPixelsPerCC = histcounts(L);%alla posiz (1) c'è il count di pixel dell'obj 0!! non 1

    for j = 1:N %numPixelsPerCC(i) ha i pixel dell'obj i+1, perchè a posiz 1 ha quelli dello sfondo!
        if numPixelsPerCC(j+1) < 250 %dipende dalla size
            mask = L==j;
            mask = mask.*j;
            figure(j), imshow(mask.*36);
            [rows,cols] = find(mask);%coordinates for the pixels in object j
            L = L - mask;
%             L =double( uint8(L)-mask);
        end
    end

    figure, imshow(L);

end