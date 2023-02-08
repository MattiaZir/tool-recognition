close all;clear all;
%tutta la pic è fatta da una sola texture. devo classificare la pic tutta.

%Sono dati due file di testo: images.list e labels.list
%il primo ha i nomi dei file uno per riga; l'altro uno per riga ha la label
%associata al file sulla stessa riga dell'altro file. è la ground truth.

%in realtà questo file fa solo il computo e save dei descittori(features)
[images, labels] = readlists();

lbp = [];
cedd = [];
qhist = [];

for j = 1: numel(images)%per ogni pic
    
    im = imread(['simplicity\', images{j}]);
    lbp = [lbp; compute_lbp(im)];%brutto ma veloce da scrivere; aggiungo al vettore sè stesso e il nuovo elem. ciocca è pigro, dovrei creare i 3 array di supporto grandi N=#immagini e valorizzo una cella alla volta
    cedd = [cedd; compute_CEDD(im)];
    qhist = [qhist; compute_qhist(im)];

end

save("data.mat", "images", "labels", "lbp", "qhist", "cedd");
%ho computato e serializzato le features per ogni pic
















