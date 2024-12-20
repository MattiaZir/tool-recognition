

% images, titles e comments devono essere della stessa lunghezza
function out_fig = comparePics(images, titles, comments)
    fig = figure("Visible", "off");

    for i = 1:length(images)
        subplot(1, length(images), i),
        imshow(images{i}),
        title(titles(i));
        xlabel(comments(i));
    end

    out_fig = fig;
end