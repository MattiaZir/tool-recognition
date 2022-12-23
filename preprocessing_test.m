close all;
clear all;

% grey = rgb2gray(im);
% 
% sharpened = imsharpen(grey, "Radius", 5, "Amount", 1.5, "Threshold", 0.2);
% imshow(sharpened);
% 
% imbinarize(sharpened, "adaptive","ForegroundPolarity", 'dark', 'Sensitivity', 0.4);


%% BINARIZZAZIONE CON SHARPENING

im = imread('data\0007.jpg');
folder = "\esperimenti\sharpening\";
grey = rgb2gray(im);
radiuses = [5, 11];
amounts = [1.5, 2.0];
idx = 0;

for rad = 1:length(radiuses)
    for am = 1:length(amounts)
        sharp = imsharpen(grey, ...
            "Radius", radiuses(rad), ...
            "Amount", amounts(am));
%         imwrite(tmp, "C:\Users\MaxDankness\Documents\Progetti\elab_immagini\tool-recognition\esperimenti\sharpening\" ...
%             + radiuses(rad) + '_' + amounts(am) + ".png");

         bin = imbinarize(sharp, "adaptive", "ForegroundPolarity", "dark", "sensitivity", 0.4);
%         imwrite(tmp, "bin_" ...
%             + radiuses(rad) + '_' + amounts(am) + ".png");


        idx = idx + 1;
    end
end