function out = compute_average_color(tass)
    [r c ch] = size(tass);
    
    tmp = reshape(tass, [r*c, ch]);
    out = mean(tmp);
%meglio di v perchè posso avere più/meno canali di 3

%     R = tass(:,:,1);
%     G = tass(:,:,2);
%     B = tass(:,:,3);
%     rmedio = mean(R(:));%R era una matrice, a(:) la stira in un vettore
%     gmedio = mean(G(:));
%     bmedio = mean(B(:));
%     out=[rmedio, gmedio, bmedio];
end