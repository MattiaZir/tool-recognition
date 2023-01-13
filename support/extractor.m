% Input:
%   region: immagine binaria che rappresenta la regione su cui calcolare le proprietà.
% Output:
%   out : tabella con le proprietà e i momenti della regione.
function out = extractor(region)    
    % Calcolo le proprietà delle regioni
    cc_props = regionprops(region, ["Area", "Perimeter", "BoundingBox", ...
    "EulerNumber", "Centroid", "Eccentricity", "Circularity", "Solidity"]);

    tmp.props = cc_props; % proprietà
    tmp.moments = hu_moments(region, cc_props.Centroid);

    out = creaTabellaDaRegionProps(tmp);
end