clear;
close all;
addpath(genpath('support/'));
[images, l] = readlists();
n = numel(images);
mkdir(".\esperimento_1");


for j = 1 : 10 : n
    im = im2double(imread(images{j}));
    results = ones(size(im, 1), size(im, 2));
    [L,numLabels] = superpixels(im,1000);
    [r, c, ch] = size(im);
    

    outputImage = zeros(size(im),'like',im);
    idx = label2idx(L);

    for labelVal = 1:numLabels
        redIdx = idx{labelVal};
        greenIdx = idx{labelVal}+r*c;
        blueIdx = idx{labelVal}+2*r*c;

        outputImage(redIdx) = mean(im(redIdx));
        outputImage(greenIdx) = mean(im(greenIdx));
        outputImage(blueIdx) = mean(im(blueIdx));
    end  

    [L,numLabels] = superpixels(outputImage, 800);
    idx = label2idx(L);

    for labelVal = 1:numLabels
        redIdx = idx{labelVal};
        greenIdx = idx{labelVal}+r*c;
        blueIdx = idx{labelVal}+2*r*c;

        outputImage(redIdx) = mean(im(redIdx));
        outputImage(greenIdx) = mean(im(greenIdx));
        outputImage(blueIdx) = mean(im(blueIdx));
    end

    figure("Visible","off"), imshow(outputImage);
    saveas(gcf, "./esperimento_1/" + j, 'png');
end