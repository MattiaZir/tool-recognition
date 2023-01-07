function out = segmentaViaClassificazione(im)
    [r c ch] = size(im);

    load("classifier");
    res = compute_local_descriptors(im, 30, 15, @compute_lbp);%prima era 30 15

    res = compute_local_descriptors(im, 15, 1, @compute_std_dev2);           
    test.values = res.descriptors;
      
    predicted = predict(classifier, test.values);%vettore di label: 0 e 1 (ho due classi)
        
    p = reshape(predicted, r, c, 1)>0;
    out = activecontour(im,p,300);
end