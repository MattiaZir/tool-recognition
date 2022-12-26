function out = compute_composite(tass)
    col = compute_average_color(tass);    
    gray=rgb2gray(tass);        
    stat = compute_std_dev(gray);
    
    lbp = compute_lbp(uint8(255*gray));
    
    out = [col stat lbp];
end