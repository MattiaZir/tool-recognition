% Non ha più bisogno dei centroidi, li calcola da solo.
function out = hu_moments(region, gray)

ORDER_00 = [0 0];
ORDER_10 = [1 0];
ORDER_01 = [0 1];
ORDER_11 = [1 1];
ORDER_20 = [2 0];
ORDER_02 = [0 2];
ORDER_21 = [2 1];
ORDER_12 = [1 2];
ORDER_30 = [3 0];
ORDER_03 = [0 3];
centroid = regionprops(region, gray, "WeightedCentroid").WeightedCentroid;

xMean = centroid(1);
yMean = centroid(2);
mu00 = calculateMoment(ORDER_00, gray, 0, 0);

% normalizzazione dei momenti (e calcolo direttamente)
% primo ordine


mu00_gamma = power(mu00, 3/2);
mu10 = calculateMoment(ORDER_10, gray, xMean, yMean)/mu00_gamma;
mu01 = calculateMoment(ORDER_01, gray, xMean, yMean)/mu00_gamma;
% secondo ordine
mu00_gamma = power(mu00, 2/3);
mu11 = calculateMoment(ORDER_11, gray, xMean, yMean)/mu00_gamma;
mu20 = calculateMoment(ORDER_20, gray, xMean, yMean)/mu00_gamma;
mu02 = calculateMoment(ORDER_02, gray, xMean, yMean)/mu00_gamma;

% terzo ordine
mu00_gamma = mu00;
mu21 = calculateMoment(ORDER_21, gray, xMean, yMean)/mu00_gamma;
mu12 = calculateMoment(ORDER_12, gray, xMean, yMean)/mu00_gamma;
mu30 = calculateMoment(ORDER_30, gray, xMean, yMean)/mu00_gamma;
mu03 = calculateMoment(ORDER_03, gray, xMean, yMean)/mu00_gamma;

%Calcolo i momenti di hu

h(1) = mu20 + mu02;
h(2) = (mu20 - mu02)^2 + 4*(mu11)^2;
h(3) = (mu30 - 3*mu12)^2 + (3*mu21 - mu03)^2;
h(4) = (mu30 + mu12)^2 + (mu21 + mu03)^2; %dalla prossima ci si diverte
h(5) = (mu30 - 3*mu12)*(mu30 + mu12)*((mu30 + mu12)^2 - 3*(mu21 + mu03)^2) + (3*mu21 - mu03)*(mu21 + mu03)*(3*(mu30 + mu12)^2 - (mu21 + mu03)^2); %dovrebbe essere giusta
h(6) = (mu20 - mu02)*((mu30 + mu12)^2-(mu21 + mu03)^2)+ 4*mu11*(mu30 + mu12)*(mu21 + mu03);
h(7) = (3*mu21 - mu03)*(mu30 + mu12)*((mu30 + mu12)^2 - 3*(mu21 + mu03)^2) + (3*mu12 - mu30)*(mu21 + mu03)*(3*(mu30 + mu12)^2 - (mu21 + mu03)^2);

% normalizzo il vettore (-sign(h) inverte i segni, poi lo moltiplica per il
% log(10) del valore assoluto di h, si chiama "normalizzazione
% logaritmico-modulare
out = -sign(h).*log10(abs(h));
end


function moment = calculateMoment(orderArr, region, xm, ym)
vector = region(:);
[~, nCol] = size(region);
moment = 0;

for px = 1:length(vector)
    x = ceil(px / nCol); % trova indice riga
    y = px - (x - 1) * nCol; % trova indice colonna

    moment = moment + (power(x - xm, orderArr(1)) * ...
        power(y - ym, orderArr(2))*region(px));
end
end