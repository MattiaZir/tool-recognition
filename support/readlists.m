%READLISTS support function
%   [images,symbolicLabels, paths2gt] = READLISTS() restituisce i nomi dei file con un
%   oggetto solo in images, in symbolicLabels alla posizione i c'è
%   l'etichetta di images{i}. in paths2gt ci sono uno i path dei
%   corrispettivi file annotati.
%   [images,symbolicLabels, paths2gt] = READLISTS('singular') restituisce i nomi dei file con un
%   oggetto solo in images, in symbolicLabels alla posizione i c'è l'etichetta di images{i}.in paths2gt ci sono uno i path dei
%   corrispettivi file annotati.
%   [images,symbolicLabels,paths2gt, labels_meaning] = READLISTS('multiple') restituisce i nomi dei file con più oggetti, in images, in labels{i} c'è la il nome della maschera(un immagine) che labella quel file images{i}.
%   in labels_meaning c'è l'associazione etichetta numerica(valore del
%   singolo pixel nella mask) <---> etichetta simbolica. vale per ogni
%   mask. symbolicLabels varrà un valore da non leggere.

function [images, symbolicLabels, paths2gt, labels_meaning] = readlists(type)
    labels_meaning={};
    paths2gt={};

    if nargin < 1
        type='singular';
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

        c2 = {};
        for i= 1 : numel(z{1})
            
            c2={c2{:}, strcat('data/annotaz/', strrep(z{1}{i}, '.jpg', '.png'))};
        end        
        paths2gt = c2;
        
        f=fopen('labels.list');
        l = textscan(f,'%s');
        fclose(f);
        symbolicLabels = l{:};

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
        zz = textscan(f,'%s');
        fclose(f);
        c = {};
        for i= 1 : numel(zz{1})
            c={c{:}, strcat('data/PixelLabelData/PixelLabelData/', zz{1}{i})};
        end        
        paths2gt = c;

        symbolicLabels = {};

        labels_meaning = {
            {0, 'sfondo'},
            {1, 'pinza'},
%da finire
        }
    end
end
