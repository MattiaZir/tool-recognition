function fig = mostraGuessedLabels(im, scale_res, cetriOggetti, lbls)
    
%     scale_fac = size(im, 1:2)./scale_res;
%     cetriOggetti = cetriOggetti.*repmat(scale_fac, [1 2]);
    for i=1: numel(lbls)
        centroObj = cetriOggetti(i,:);
        [x, y, ~] = size(im);
        scaleFactorx = x /scale_res(1);
        scaleFactory = y /scale_res(2);
        centroObj(1) = centroObj(1) * scaleFactorx;
        centroObj(2) = centroObj(2) * scaleFactory;
        im = insertText(im, centroObj, lbls(i), FontSize=30);
    end
    fig = im;
end
