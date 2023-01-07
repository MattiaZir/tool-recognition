function out = labelingCompConn(bw, i)
    if mod(i,2)==0
        bw = bwareaopen(bw, 50); %removes all connected components (objects) that have fewer than P pixels(2nd parameter)
        bw = imclose(bw, strel('disk', 4));
    end
    [L,N] = bwlabel(bw,8);
    numPixelsPerCC = histcounts(L);%alla posiz (1) c'è il count di pixel dell'obj 0!! non 1

           
    L = imclearborder(L,4);%tolgo gli obj che toccano i bordi

    out = L;

end