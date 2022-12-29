%READLISTS support function
%   [images,labels] = READLISTS() restituisce i nomi dei file con un
%   oggetto solo in images, in labels alla posizione i c'è l'etichetta di images{i}.
%   [images,labels] = READLISTS('singular') restituisce i nomi dei file con un
%   oggetto solo in images, in labels alla posizione i c'è l'etichetta di images{i}.
%   [images,labels, labels_meaning] = READLISTS('multiple') restituisce i nomi dei file con più oggetti, in images, in labels{i} c'è la il nome della maschera(un immagine) che labella quel file images{i}.
%   in labels_meaning c'è l'associazione etichetta numerica(valore del
%   singolo pixel nella mask) <---> etichetta simbolica. vale per ogni mask.

function [images,labels, labels_meaning]=readlists(type)
    if nargin < 1
        type='singular';
        labels_meaning={};
    end

    if strcmp(type,'singular')
        f=fopen('images.list');
        z = textscan(f,'%s');
        fclose(f);
        c = {};
        for i= 1 : numel(z{1})
            c={c{:}, strcat('data/', z{1}{i})};
        end        
        images = c;
        
        f=fopen('labels.list');
        l = textscan(f,'%s');
        labels = l{:};
        fclose(f);

    elseif strcmp(type, 'multiple')

        f=fopen('composite_images.list');
        z = textscan(f,'%s');
        fclose(f);
        c = {};
        for i= 1 : numel(z{1})
            c={c{:}, strcat('data/composite_images/', z{1}{i})};
        end        
        images = c;
        
        f=fopen('composite_labels.list');
        z = textscan(f,'%s');
        fclose(f);
        c = {};
        for i= 1 : numel(z{1})
            c={c{:}, strcat('data/PixelLabelData/PixelLabelData/', z{1}{i})};
        end        
        labels = c;

        labels_meaning = {
            {0, 'sfondo'},
            {1, 'pinza'},

        }
    end
end
