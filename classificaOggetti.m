% input: 
% cc:   l' immagine delle n comp connesse, n = unique(cc)-1
% pic_raw: 
% labels_meaning: mappa id <--> stringa di significato
% output: 
% cetriOggetti: tabella di n righe e 2 colonne; n= num oggetti/cc; colonne:
% x,y (coord del centroide di quell'oggetto di quella riga)
% labelsObjs: cetriOggetti è un array di label (stringhe)
% immagineLayerOggetti: è una pic con a 1 i pixel dove ritiene ci sia un  forbice a 2 i pixel dove c'è un metro ...
function [cetriOggetti, labelsObjs, immagineLayerOggetti] = classificaOggetti(cc, pic_raw, labels_meaning)
    addpath(genpath('support/'));
%     load('trainedModelConDati');%decommenta per usare il calssifier suo trainato
    load('classifierOggetti.mat')
    labelT = 0.2; % threshold dell'oggetto, se è < del valore, è "unknown"
    cc_unique = unique(cc);
    cetriOggetti = [];
    labelsObjs = [];
    
    tmpImage = zeros(size(cc));%pic di double grande come l'originale in cui metterò 1 dove riconosco una forbice 2 dove riconosco un metro ...

    for i = 2:length(cc_unique) %il primo elem di cc_unique è 0 ->lo sfondo -> parto dal secondo
        
        %calcolo feature di texture su tutta la pic; farlo fare a estraiFeatures solo sulla reg dell'obj verrebbe male
        res = compute_local_descriptors(pic_raw, 30, 1, @compute_std_dev2);
        stdPuntuale = reshape(res.descriptors, [res.nt_rows res.nt_cols]);

        regione = cc==cc_unique(i);
        featuresEstratte = estraiFeatureDaRegione(regione, stdPuntuale);

        cetroOggetto = featuresEstratte.Centroid;
        featuresEstratte = removevars(featuresEstratte,["Centroid"]);%non facciamolo allenare sul centroid -> lo tolgo dalla tabella.        
        
%          featuresEstratte
        [label, prob] = predict(classifierOggetti, splitvars(featuresEstratte));
%         [label, prob] = trainedModelConDati.predictFcn(splitvars(featuresEstratte)); %decommenta per usare il calssifier suo trainato
%         "accuratezza"
%         max(prob)

        labelNumber=-1;

        if(max(prob) < labelT)
            labelNumber = 11; % "unknown"
            label = "sconosciuto";
        end

        %trovo il numero che corrisponde a quella label nei dati annotati
        for j = 1: numel(labels_meaning)
            a = labels_meaning{j};            
            if strcmp(a{2}, label) % il secondo elem è la stringa della label
                labelNumber = j-1;
                break;
            end
        end
    
        assert(labelNumber~=-1);

        tmpImage = tmpImage+ (regione.*labelNumber);

        cetriOggetti = [cetriOggetti; cetroOggetto];
        labelsObjs = [labelsObjs; label];
    end
    immagineLayerOggetti = tmpImage;
end