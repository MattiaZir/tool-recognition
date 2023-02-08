clear all;
close all;

coins = rgb2gray(imread("euro_coins.png"));


bw = coins<240;%pic binaria ottenuta sogliando
bw = medfilt2(bw, [7 7]);
subplot(3,3,1), imshow(bw);

labels = bwlabel(bw);

subplot(3,3,2),imagesc(labels), axis image;%imagesc è per visualizzare matrici che non per forza sono immagini uint8 o double o standar comunque (anche val negativi posso avere)

mask50cent = (labels == 5);%mask binaria che ha a 1 solo dove ho i 50 cents; label==5 dà solo i pixel dove vale la condiz che lì ho il 5o label
mask50int = uint8(mask50cent);
subplot(3,3,3), imshow(mask50cent);

out = mask50int .* coins; 
subplot(3,3,4), imshow(out);%solo la moneta da 50 cent


%c'è pure REGIONPROPS che dà direttamente le bounding box che rileva dalla
%pic raw e mi evita di lavorare con maschere io...