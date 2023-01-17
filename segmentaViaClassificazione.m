function out = segmentaViaClassificazione(im)
    [r c ch] = size(im);

    load("classifierSfondo");

    res = compute_local_descriptors(im, 15, 1, @compute_std_dev2);           
    test.values = res.descriptors;
      
    predicted = predict(classifierSfondo, test.values);%vettore di label: 0 e 1 (ho due classi)
        
    p = reshape(predicted, r, c, 1)>0;
    
    p = activecontour(im,p,300);

    out = imclose(p, strel('disk',5));
end