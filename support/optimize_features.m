function out = optimize_features(featureTable, numFeatures)

    if numFeatures > size(featureTable, 2)
        numFeatures = size(featureTable, 2);
    end

    arr = table2array(featureTable);
    pcamat = pca(arr);
    toppca = pcamat(:, 1:numFeatures); % prende il top k delle features
    
    out = normalize(arr*toppca, "range"); % <--- lo normalizza ( da vedere se farlo o no)
end

