function fig = mostraGuessedLabels(im, scale_res, bBoxLocs, lbls)
    scale_fac = size(im, 1:2)./scale_res;
    bBoxLocs = bBoxLocs.*repmat(scale_fac, [1 2]);
    fig = insertObjectAnnotation(im, "rectangle", bBoxLocs, lbls);
end