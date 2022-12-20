function out = chromaSub(im)
    [row, col, ch] = size(im);

    resampler = vision.ChromaResampler;
    resampler.Resampling="4:4:4 to 4:1:1";
    
    imageYCbCr = rgb2ycbcr(im);
    [Cb,Cr] = resampler(imageYCbCr(:,:,2), imageYCbCr(:,:,3));
    out = ycbcr2rgb(cat(3, imageYCbCr(:,:,1), imresize(Cb, [row col]), imresize(Cr, [row col])));
end

