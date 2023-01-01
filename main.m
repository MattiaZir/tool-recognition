clear;
close all;
addpath(genpath('support/'));
[images, dummy, paths2gt, labels_meaning] = readlists();
n = numel(images); 


for i = 1 : 1 % solo 1 pic ha la gt quindi... 1:1 e non 1:n
    im = imread(images{i});
    im = imresize(im, [768, 1024]);
    im = im2double(rgb2gray(im));
    im = medfilt2(im, [10 10]);
    im = imfilter(im, fspecial("gaussian", 10, 1.8));

    
    bw = segmenta(im);
    
    figure, imshow(bw);


%     figure, imshow(im);
%     bw = imopen(bw, strel('disk',5));
%     bw = imclose(bw, strel('disk',10));
    


    [L,N] = bwlabel(bw,8);
    numPixelsPerCC = histcounts(L);%alla posiz (1) c'è il count di pixel dell'obj 0!! non 1

    for j = 1:N %numPixelsPerCC(i) ha i pixel dell'obj i+1, perchè a posiz 1 ha quelli dello sfondo!
        if numPixelsPerCC(j+1) < 450 %dipende dalla size
            mask = L==j;
            mask = mask.*j;
%             figure(j), imshow(mask.*36);
            [rows,cols] = find(mask);%coordinates for the pixels in object j
            L = L - mask;
        end
    end
    
    
    
    L = imclearborder(L,4);%tolgo gli obj che toccano i bordi
    figure, imshow(L);

end