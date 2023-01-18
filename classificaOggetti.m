% input: l' immagine delle n comp connesse, n = unique(cc)-1
function [bBox, objs] = classificaOggetti(cc, labels_meaning)
    addpath(genpath('support/'));
    load('classifierOggetti');
    
    labelT = 0.5; % threshold dell'oggetto, se è < del valore, è "unknown"
    cc_unique = unique(cc);
    bBox = [];
    objs = [];
    
    tmp = zeros(size(cc));%pic grande come l'originale in cui metterò 1 dove riconosco una forbice 2 dove riconosco un metro ...

    for i = 1:length(cc_unique) % parte da 2 perché 1 corrisponde allo sfondo ??????????
        regione = cc==i;
        T = splitvars(extractor(regione)); %splitto gli hu_moments per dopo
        [label, prob] = predict(classifierOggetti, splitvars(T));
    
        if(max(prob) < labelT)
            label = 11; % "unknown"
        end
    
        % proprietà per il labeling sull'immagine
        bBox = [bBox; uint8(regionprops(tmp, "BoundingBox").BoundingBox)];
        objs = [objs; label];
    end

end