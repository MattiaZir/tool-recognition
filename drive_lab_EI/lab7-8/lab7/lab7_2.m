close all;clear all;

%dato che ho solo quelle 200 foto in mano... non le uso tutto per il
%training: divido le 200 in training e test


load("data.mat");%mi ficca nel workspace le var deserializzate


cv = cvpartition(labels, "Holdout", 0.2); %Holdout->volgio insiemi disgiunti; 3o param è % di quanto per il training
%il 20% delle pic di ogni classe/label saranno nel test set. (20% non vuol
%dire che prende 1/5 delle pic a caso, sennò magari non ho campiono per una
%classe)

tr = cv.training(1);%se param>1 è quando voglio crossvalidation. 1= dividi il training set in 1 set solo.(non lo subdivide)
ts = cv.test(1);


train.images = images(tr);%tutte le pic selezionate per il training

%creo oggetto train
train.labels = labels(tr);
train.lbp = lbp(tr,:);
train.ghist = ghist(tr,:);
train.glcm = glcm(tr,:);


%creo oggetto test
test.labels = labels(ts);
test.lbp = lbp(ts,:);
test.ghist = ghist(ts,:);
test.glcm = glcm(ts,:);


save("data2.mat", "train", "test");








