function out = extractor(region)    
    % Calcolo le proprietà delle regioni
    cc_props = regionprops(region, ["Area", "Perimeter", "BoundingBox", ...
    "EulerNumber", "Centroid", "Eccentricity", "Circularity", "Solidity"]);

    tmp.props = cc_props; % proprietà
    tmp.moments = hu_moments(region, cc_props.Centroid);

    out = creaTabellaDaRegionProps(tmp);
end