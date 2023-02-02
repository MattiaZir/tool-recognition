function [normalizzate, MinOut, MaxOut] = normalizza(tabellaFeatures, MinInput, MaxInput)
    MaxOut = [];
    MinOut= [];
    normalizzate = tabellaFeatures;
    [numRows numCols] = size(tabellaFeatures);

    if nargin == 1
        
        for c = 1 : numCols
            massimoDiColonna = max(table2array(tabellaFeatures(:,c)));
            minimoDiColonna = min(table2array(tabellaFeatures(:,c)));            
            MinOut= [MinOut;minimoDiColonna];
            MaxOut= [MaxOut;massimoDiColonna];
            for r = 1 : numRows
                tmp = tabellaFeatures(r,c);
                normalizzate(r, c) = {(tmp{1,1} -minimoDiColonna) / (massimoDiColonna - minimoDiColonna)};
            end
        end
    elseif nargin ==3 %faccio solo rescale avendo i min ed i max
        for c = 1 : numCols
            for r = 1 : numRows
                tmp = tabellaFeatures(r,c);
                normalizzate(r, c) = {(tmp{1,1} -MinInput(c)) / (MaxInput(c) - MinInput(c))};
            end
        end
    end   
end