function out = segmenta(im)
    [r c ch] = size(im);

    res = compute_local_descriptors(im, 30, 15, @compute_lbp);%prima era 30 15

    labels = kmeans(res.descriptors, 2); %Rows of 1st argument correspond to points and columns correspond to variables. 
    counts = histcounts(labels);


    labels_image = reshape(labels, [res.nt_rows res.nt_cols]);%la pic della label è 5 volte più piccola di raw
    labels_image = imresize(labels_image, [r,c], "nearest");%uso Nneighbor per non fargli generare nuovi valori di labels

    if(counts(1)>counts(2)) %cerco classe + numerosa (lo sfondo)
        out = labels_image==2;
    else
        out = labels_image==1;
    end
end