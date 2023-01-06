

function trainer(imsize, winsize, stepsize, ksize, start_im, end_im, savedir)
    addpath(genpath('support/'));
    [images, ~, paths2gt, labels_meaning] = readlists();
    n = numel(images); 
    %classificatore knn per trovare i pixel di una immagine che sono di obj
    
    train_values=[];
    train_labels=[];

    tic
    for i = start_im:end_im
        im = im2double(imread(images{i}));
        im = rgb2gray(imresize(im, imsize,"nearest"));
    
        gt = imread(paths2gt{i});
        gt = imresize(gt(:,:,1), imsize,"nearest")>0;    
        gt = uint8(gt);
    
        [r c ~] = size(im);
        res = compute_local_descriptors(im, winsize, stepsize, @compute_std_dev2);    
        [rs,cs,ch] = size(res.descriptors); % 12288 x 59 x 1
        train_values = vertcat(train_values, res.descriptors);
        labels_vector = reshape(gt, [r*c 1]); % 12288 x 1 vettore
        train_labels = vertcat(train_labels, labels_vector);

    end
    timed = toc;
    
    classifier = fitcknn(train_values, train_labels, "NumNeighbors", ksize);
    save("classifier", "classifier");
    
    % qui salvo i parametri usati
    fid = fopen(savedir + '/classifier_params.txt', 'wt');
    fprintf(fid, "Larghezza immagine: %i\nLunghezza immagine: %i\n" + ...
        "Finestra: %i\nStep: %i\nNeighbors: %i\nNumero immagine partenza: %i\n" + ...
        "Numero immagine fine: %i\nTempo impiegato: %.3f secondi", ...
        imsize, winsize, stepsize, ksize, start_im, end_im, timed);
    fclose(fid);
end
