function out = compute_composite(tass)
    col = compute_average_color(tass);    
    gray=rgb2gray(ycbcr2rgb(tass));  
    stat = compute_std_dev(gray);

    lbp = compute_lbp(uint8(255.*gray));% * oppure .* boh
    
    out = [col stat lbp];
end