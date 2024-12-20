
function [bBox, objs] = classify(cc)
load('objClassifier');

mdl = objClassifier.ClassificationTree;
labelT = 0.85; % threshold dell'oggetto, se è < del valore, è "unknown"
cc_unique = unique(cc);
bBox = [];
objs = [];

for k = 2:length(cc_unique) % parte da 2 perché 1 corrisponde allo sfondo
    tmp = ismember(cc, cc_unique(k)); % prende solo una delle regioni
    T = splitvars(extractor(tmp)); %splitto gli hu_moments per dopo
    [label, prob] = predict(mdl, splitvars(T));

    if(max(prob) < labelT)
        label = "unknown";
    end

    % proprietà per il labeling sull'immagine
    bBox = [bBox; regionprops(tmp, "BoundingBox").BoundingBox];
    objs = [objs; label];
end

end