function compute_mean_confmat(accu, cm_all, cmr_all)
mean(accu,"all","omitnan")
mean(cm_all, 3, "omitnan")
round(mean(cmr_all, 3, "omitnan"));

figure, show_confmat(round(mean(cmr_all, 3, "omitnan")), ["noskin", "skin"]);
end