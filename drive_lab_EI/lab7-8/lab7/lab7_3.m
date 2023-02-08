close all;clear all;

load("data2.mat");
ftr = [train.ghist, train.lbp, train.glcm];%uso queste var come indirection per le vere features
fts = [test.ghist, test.lbp, test.glcm];


%costruisco albero di decisione (uso solo una feature o un array di features)
%C = fitctree(ftr, train.labels);
C = fitcknn(ftr, train.labels, "numneighbors", 3);


predicted = predict(C, ftr);%label predette. i dati sono quelli di training dove dovrebbe fare benissimo(l'ho addestrato su questi)
%view(C, "mode", "graph");
performance_training = confmat(predicted, train.labels)

show_confmat(performance_training.cm_raw, performance_training.labels);

predicted = predict(C, fts);%label predette. i dati sono quelli di test. sono nuovi per lui

performance_training = confmat(predicted, test.labels)
figure(2);
show_confmat(performance_training.cm_raw, performance_training.labels);









