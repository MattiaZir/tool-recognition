% Non sono sicuro funzioni, è orribile
function out = hu_moments(region, centroid)
    nm = zeros(3);
    mu00 = calculateMoment([0 0], region, 0, 0);

    mu10 = calculateMoment([1 0], region, 0, 0);
    mu01= calculateMoment([0 1], region, 0, 0);
    mu11 = calculateMoment([1 1], region, 0, 0);
    mu20 = calculateMoment([2 0], region, 0, 0);
    mu02 = calculateMoment([0 2], region, 0, 0);
    mu21 = calculateMoment([2 1], region, 0, 0);
    mu12 = calculateMoment([1 2], region, 0, 0);
    mu30 = calculateMoment([3 0], region, 0, 0);
    mu03 = calculateMoment([0 3], region, 0, 0);

    % ricalcolo con le medie e normalizzo
    xMean = centroid(1);
    yMean = centroid(2);

    % normalizzazione
    % primo ordine
    mu00_gamma = mu00^((1/2)+1);
    mu10 = calculateMoment([1 0], region, xMean, yMean)/mu00_gamma;
    mu01 = calculateMoment([0 1], region, xMean, yMean)/mu00_gamma;
    % secondo ordine
    mu00_gamma = mu00^(2);
    mu11 = calculateMoment([1 1], region, xMean, yMean)/mu00_gamma;
    mu20 = calculateMoment([2 0], region, xMean, yMean)/mu00_gamma;
    mu02 = calculateMoment([0 2], region, xMean, yMean)/mu00_gamma;
    
    % terzo ordine
    mu00_gamma = mu00^(3);
    mu21 = calculateMoment([2 1], region, xMean, yMean)/mu00_gamma;
    mu12 = calculateMoment([1 2], region, xMean, yMean)/mu00_gamma;
    mu30 = calculateMoment([3 0], region, xMean, yMean)/mu00_gamma;
    mu03 = calculateMoment([0 3], region, xMean, yMean)/mu00_gamma;

    %Calcolo i momenti di hu
    
    h(1) = mu20 + mu02; 
    h(2) = (mu20 - mu02)^2 + 4*(mu11)^2; 
    h(3) = (mu30 - 3*mu12)^2 + (3*mu21 - mu03)^2;
    h(4) = (mu30 + mu12)^2 + (mu21 + mu03)^2; %dalla prossima ci si diverte
    h(5) = (mu30 - 3*mu12)*(mu30 + mu12)*((mu30 + mu12)^2 - 3*(mu21 + mu03)^2) + (3*mu21 - mu03)*(mu21 + mu03)*(3*(mu30 + mu12)^2 - (mu21 + mu03)^2); %dovrebbe essere giusta
    h(6) = (mu20 - mu02)*((mu30 + mu12)^2-(mu21 + mu03)^2)+ 4*mu11*(mu30 + mu12)*(mu21 + mu03);
    h(7) = (3*mu21 - mu03)*(mu30 + mu12)*((mu30 + mu12)^2 - 3*(mu21 + mu03)^2) + (3*mu12 - mu30)*(mu21 + mu03)*(3*(mu30 + mu12)^2 - (mu21 + mu03)^2);

    out = h;
end

function moment = calculateMoment(orderArr, region, xm, ym)
    vector = region(:);
    [~, nCol] = size(region);
    moment = 0;

    for px = 1:length(vector)
        x = ceil(px / nCol); % trova indice riga
        y = px - (x - 1) * nCol; % trova indice colonna
        
        moment = moment + (((x - xm)^orderArr(1)) * ((y - ym)^orderArr(2))*region(px));
    end
end