function out = segmenta(im)
    [r c ch] = size(im);

    load("classifier");

    res = compute_local_descriptors(im, 15, 1, @compute_std_dev2);           
    test.values = res.descriptors;
      
    predicted = predict(classifier, test.values);%vettore di label: 0 e 1 (ho due classi)
        
    p = reshape(predicted, r, c, 1)>0;
    p = imclose(p, strel('disk', 4));
    out = activecontour(im,p,300);
end