function [L, N] = labelingCompConn(bw)

    
    [L,N] = bwlabel(bwareaopen(bw, 100),8);
%     numPixelsPerCC = histcounts(L);%alla posiz (1) c'è il count di pixel dell'obj 0!! non 1
% 
%     %tolgo gli obj piccoli
%     for j = 1:N %numPixelsPerCC(i) ha i pixel dell'obj i+1, perchè a posiz 1 ha quelli dello sfondo!
%         if numPixelsPerCC(j+1) < 50 %dipende dalla size TODO MIGLIORA
%             mask = L==j;
%             mask = mask.*j;
% %             figure(j), imshow(mask.*36);
%             [rows,cols] = find(mask);%coordinates for the pixels in object j
%             L = L - mask;
%         end
%     end
    
    
    
    L = imclearborder(L,4);%tolgo gli obj che toccano i bordi
%     figure, imshow(L);
end