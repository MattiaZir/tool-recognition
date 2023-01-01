function out = labelingCompConn(bw)

    
    [L,N] = bwlabel(bw,8);
    numPixelsPerCC = histcounts(L);%alla posiz (1) c'è il count di pixel dell'obj 0!! non 1

    for j = 1:N %numPixelsPerCC(i) ha i pixel dell'obj i+1, perchè a posiz 1 ha quelli dello sfondo!
        if numPixelsPerCC(j+1) < 450 %dipende dalla size
            mask = L==j;
            mask = mask.*j;
%             figure(j), imshow(mask.*36);
            [rows,cols] = find(mask);%coordinates for the pixels in object j
            L = L - mask;
        end
    end
    
    
    
    L = imclearborder(L,4);%tolgo gli obj che toccano i bordi
%     figure, imshow(L);
    out = L;

end