function rip_pct = torque_ripple_pct(Te_hist)
%TORQUE_RIPPLE_PCT  Peak-to-peak torque ripple as percentage of mean.
Te_mean = mean(Te_hist);
rip_pct = 100 * (max(Te_hist) - min(Te_hist)) / (2 * abs(Te_mean));
end
