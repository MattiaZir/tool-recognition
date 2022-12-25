clear;
close all;
input_dir = 'Progetto/data/unoperpic';
filenames = dir(fullfile(input_dir, '*.jpg'));
images = [];

for n = 1:1%length(filenames)/4
    filename = fullfile(input_dir, filenames(n).name);
    ycbcr = rgb2ycbcr(imread(filename));
    imf = medfilt2(imadjust(ycbcr(:,:,1),[0.05, 0.95]), [5 5]);
    imf = imfilter(imf, fspecial("gaussian", 7, 1.2));

    bw=1-imbinarize(imf,adaptthresh(imf,0.5,"ForegroundPolarity","dark"));
    subplot(3,1,1), imshowpair(ycbcr2rgb(ycbcr), bw, "montage"), title("Y");

        imf = medfilt2(imadjust(ycbcr(:,:,2),[0.05, 0.95]), [5 5]);
    imf = imfilter(imf, fspecial("gaussian", 7, 1.2));

    bw=imbinarize(imf,adaptthresh(imf,0.5,"ForegroundPolarity","bright"));
    subplot(3,1,2), imshowpair(ycbcr2rgb(ycbcr), bw, "montage") , title("Cb");

            imf = medfilt2(imadjust(ycbcr(:,:,3),[0.05, 0.95]), [5 5]);
    imf = imfilter(imf, fspecial("gaussian", 7, 1.2));

    bw=imbinarize(imf,adaptthresh(imf,0.5,"ForegroundPolarity","bright"));
    subplot(3,1,3), imshowpair(ycbcr2rgb(ycbcr), bw, "montage") , title("Cr");

end


%sharpening funzia?
