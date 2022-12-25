%% TODO: rendi più generale il codice, da testare
%     parametri:  image1, image2 - immagini
%                 titles - array di titoli (per ora due)
%                 comments - array di stringhe ( per ora due)


function out_fig = comparePics(image1, image2, titles, comments)
        fig = figure("Visible","off");
        subplot(1,2,1), imshow(image1), title(titles(1));
        xlabel(comments(1));

        subplot(1,2,2), imshow(image2), title(titles(2));
        xlabel(comments(2));
end