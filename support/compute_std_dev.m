function out = compute_std_dev(tass)%dev standard ma anche media   
    s = std(tass(:));%ipotizzo di avere 1 canale
    m = mean(tass(:));
    out = [s m]%eventualmente potrei dover normalizzare i descrittori/features. perchè se s è 10000 e m=218 allora m non conta più 
end