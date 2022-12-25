clear;
close all;

[images, l] = readlists();
n = numel(images);

for j = 1 : 1 %PER OGNI PIC 
    im = im2double(rgb2gray(imread(strcat("Progetto/data/",images{j}))));%attento a pwd

    
    
    imf = medfilt2(imadjust(im,[0.05, 0.95]), [5 5]);
    imf = imfilter(im, fspecial("gaussian", 7, 1.2));
    %figure, imshowpair(im, imf,'montage'), title("raw vs. median+gaussian filter");
    

    otsuRaw = im2bw(im, graythresh(im));
    otsuProcessed = im2bw(imf, graythresh(imf));
    %figure, imshowpair(otsuRaw, otsuProcessed,'montage'), title("raw vs. median+gaussian filter: otsu");

    obj.pics = {im, imf};
    obj.f = {@graythresh, @graythresh};
    obj.a = {im,'|', imf};
    runAndDispay(obj);%ok è poco scalabile: se io voglio imbinarize(im, 0.42*ostu(im)) creo una funz apposta?

    


    % N=30;
    % M=15;
    % for i = 1:size(im,1)-(N-1)
    %     for j = 1:size(im,2)-(M-1)
    %         window = im(i:i+(N-1), j:j+(M-1));
    %         im(i,j) = abs(im(i,j)) < mean(window,"all")+0.05;
    %     end
    % end
    
    23                                                                                    
    sav = sauvola(im, [60 60]);
    savf = sauvola(imf, [60 60]);
    figure, imshowpair(sav, savf, 'montage'), title('raw vs. median+gaussian filter: sauvola');

%T is a numeric array, then imbinarize interprets T as a locally adaptive threshold.
    adaptive = imbinarize(im,adaptthresh(im,0.9,"NeighborhoodSize",[97 129]));
    adaptiveF = imbinarize(imf,adaptthresh(imf));
    figure, imshowpair(sav, savf, 'montage'), title('raw vs. median+gaussian filter: adaptive');


end

