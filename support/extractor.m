% Input:
%   region: immagine binaria che è la regione su cui calcolare le proprietà.
% Output:
%   out : tabella con le proprietà e i momenti della regione.
function out = extractor(region)    
    % Calcolo le proprietà delle regioni

addpath(genpath('support/'));
    cc_props = regionprops("table", region, ["MajorAxisLength", "MinorAxisLength", ...
        "EulerNumber", "Circularity", "Solidity", "Centroid", "Area"]);



    % NOTA: SE IN INPUT REGION NON è una regione connessa ma più
    % d'una...ottengo più righe -> prendo quella della regione più grande(
    % suppongo che il resto sia una regione spuria passataci come region
    % quando questa è la mask della gt annotata da noi(tutta), cioè non ho
    % fatto labelling .
    [rows ~] = size(cc_props);
    if(rows>=2)
        rigaRegPiuGrande = find(cc_props.Area == max(cc_props.Area));
        cc_props = cc_props(rigaRegPiuGrande,:);   
        
    end

    cc_props.RapportoAssi = cc_props.MajorAxisLength / cc_props.MinorAxisLength;
    cc_props = removevars(cc_props, ["MajorAxisLength", "MinorAxisLength"]);

%     cc_props.hu = hu_moments(region, cc_props.Centroid);    
%     cc_props = removevars(cc_props,["Centroid"]);
%     %non facciamolo allenare sul centroid -> poi dopo i momenti lo tolgo dalla tabella.

    cc_props = removevars(cc_props,["Area"]);
    out=cc_props;
end