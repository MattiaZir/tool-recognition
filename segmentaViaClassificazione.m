function out = segmentaViaClassificazione(im)
    [r c ch] = size(im);

    load("classifierSfondo");

    res = compute_local_descriptors(im, 30, 1, @compute_std_dev2);           
    test.values = res.descriptors;
      
    predicted = predict(classifierSfondo, test.values);%vettore di label: 0 e 1 (ho due classi)
        

%     figure, imshow(im);
    p = reshape(predicted, r, c, 1)>0;

%     figure, imshow(p);

    
    %prova del 05/02/23: vvv
    p1 = bwareaopen(p, 50); %removes all connected components (objects) that have fewer than P pixels(2nd parameter)        
    p2 = imdilate(imclose(p1, strel('disk',7)), strel('disk',7));%prova del 05/02/23
    
%     figure, imshow(p2);
    pac = activecontour(im, p2,300);

    out = imclose(pac, strel('disk',2));
%     figure, imshow(out);
end

% 
% function out = segmentaViaClassificazione(im)
%     [r c ch] = size(im);
% 
%     load("classifierSfondo");
% 
%     res = compute_local_descriptors(im, 30, 1, @compute_std_dev2);           
%     test.values = res.descriptors;
%       
%     predicted = predict(classifierSfondo, test.values);%vettore di label: 0 e 1 (ho due classi)
%         
%     p = reshape(predicted, r, c, 1)>0;
%     
%     p = activecontour(im,p,300);
% 
%     out = imclose(p, strel('disk',2));
% end