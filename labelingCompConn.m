function out = labelingCompConn(bw)
    bw = imclose(bw, strel('disk', 3));
    bw = bwareaopen(bw, 50); %removes all connected components (objects) that have fewer than P pixels(2nd parameter)        
    
    
    [L,N] = bwlabel(bw,8);%labelling vero e proprio
    L = imclearborder(L,4);%tolgo gli obj che toccano i bordi
    out = L;

end