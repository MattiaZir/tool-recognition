% COMPAREMASKS function
% methodTitle = il nome del metodo utilizzato per segmentare
% dataCsvFolder = la path del file di testo dove salvare un report di
% statistiche (es. "./esperimenti/kmeansSegm/report)
function out_f = compareMasks(methodTitle , dataCsvFolder)

    if nargin < 2
        error("too few arguments")
    end

    addpath(genpath('support/'));
    [images, labels] = readlists('singular');
    n = numel(images);
    res_table = cell2table(cell(0,3), 'VariableNames', {'#', 'label', 'errors'});
    
    for k = 1:n
        % Essendo le immagini in png, devo cambiare la stringa con strrep
        im_name = strrep(images{k}, '.jpg', '.png');
        im_name = strrep(im_name, 'data/', '');
        gt_im = imread(strcat("data/annotaz/", im_name)) > 0;
        gen_im = imread(strcat("data/generated/", im_name)) > 0;
    
        image_diff = imabsdiff(gt_im, gen_im);
        diff_sum = sum(image_diff(:));
        tmp = {k, labels{k}, diff_sum};
    
        res_table = [res_table; tmp];
    end

    % Crea la folder
    mkdir(dataCsvFolder);
    
    % Creazione dei grafici
    figure, bar(res_table.("#"), res_table.errors);
    title("Errori maschera");
    subtitle("Metodo: " + methodTitle);
    xlabel("# Immagine");
    ylabel("# Errori");
    
    saveas(gcf, dataCsvFolder + "/tot_errors", 'jpg');

    % Raggruppo le statistiche
    grouped = grpstats(res_table, "label", ["sum", "min", "max", "mean", "std"]);
    
    % ERRORI TOTALI
    figure, bar(categorical(grouped.label), grouped.sum_errors);
    title("Totale errori per label");
    xlabel("Label");
    ylabel("# Errori");

    saveas(gcf, dataCsvFolder + "/label_tot_errors", 'jpg');
    
    % MEDIA ERRORI
    figure, bar(categorical(grouped.label), grouped.mean_errors);
    title("Media errori per label");
    xlabel("Label");
    ylabel("# Errori");

    saveas(gcf, dataCsvFolder + "/label_avg_errors", 'jpg');
    
    % Creazione file
    writetable(grouped, dataCsvFolder + "/data.csv");
end