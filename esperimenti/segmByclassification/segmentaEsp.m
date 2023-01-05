% im: immagine da segmentare
% winsize: quanto dev'essere grande il tassello
% stepsize: grandezza dello step
% aciterations: quante iterazione per l'active contours
function out = segmentaEsp(im, winsize, stepsize, aciterations)
    [r c ch] = size(im);

    load("classifier");

    res = compute_local_descriptors(im, winsize, stepsize, @compute_std_dev2);           
    test.values = res.descriptors;
      
    predicted = predict(classifier, test.values);%vettore di label: 0 e 1 (ho due classi)
        
    p = reshape(predicted, r, c, 1)>0;
    p = imclose(p, strel('disk', 4));
    out = activecontour(im,p, aciterations);
end