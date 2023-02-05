% Input:
%   maskRegione: immagine binaria che è la regione su cui calcolare le proprietà
%   di forma e bordo
%   pic dove ho calcolato dei descrittori di texture
%   proprietà di texture ecc... considererò poi solo dove la mask dice che c'è la regione. % Output:
%   out : tabella con le proprietà e i momenti della regione.
function out = estraiFeatureDaRegione(maskRegione, picDevStd)    

    maskRegione = logical(maskRegione);

    [~,~, stdsobj] = find(picDevStd.*maskRegione);%tmp è un array dei valori >0
    mediaStdOggetto = mean(stdsobj, "all");

    cc_props = regionprops("table", maskRegione, ["MajorAxisLength", "MinorAxisLength", ...
        "EulerNumber", "Circularity", "Solidity", "Centroid", "Area"]);% Solidity = num pixel nella convex hull / num pixel area

    % NOTA: SE IN INPUT REGION NON è una regione connessa ma più
    % d'una...ottengo più righe -> prendo quella della regione più grande(
    % suppongo che il resto sia una regione spuria passataci come region
    % quando questa è la mask della gt annotata da noi(tutta), cioè non ho
    % fatto labelling .
    [rows ~] = size(cc_props);
    if(rows>=2)
        rigaRegPiuGrande = find(cc_props.Area == max(cc_props.Area));
        cc_props = cc_props(rigaRegPiuGrande, :);           
    end

%     cc_props

    cc_props.RapportoAssi = cc_props.MajorAxisLength / cc_props.MinorAxisLength;
    cc_props = removevars(cc_props, ["MajorAxisLength", "MinorAxisLength"]);

    cc_props.hu = hu_moments(maskRegione, cc_props.Centroid);    
%     cc_props = removevars(cc_props,["Centroid"]);
%     %non facciamolo allenare sul centroid -> poi dopo i momenti lo tolgo dalla tabella.
    

    %aggiungo descrittori di texture
    cc_props.mediaStdOggetto = mediaStdOggetto;


    cc_props = removevars(cc_props,["Area"]);
    out=splitvars(cc_props, "hu");
end