function out_cm = compute_mean_confmat(cm_struct)

accr = [];
cmr_all = [];
cm_all = [];

for k = 1:length(cm_struct)
    accr = [accr cm_struct.accuracy];
    cmr_all(:,:,k) = cm_struct.cm_raw;
    cm_all(:,:,k) = cm_struct.cm;
end

out_cm.accuracy = mean(accr,"all","omitnan");
out_cm.cm_raw = round(mean(cmr_all, 3, "omitnan"));
out_cm.cm = mean(cm_all, 3, "omitnan");
out_cm.labels = ['sfondo', 'oggetto'];

end