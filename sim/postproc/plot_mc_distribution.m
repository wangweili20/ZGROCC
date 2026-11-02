function plot_mc_distribution(results, method_names)
%PLOT_MC_DISTRIBUTION  Fig 1: violin/histogram of RMSE across replications.
figure('Position',[100 100 900 400]);
subplot(1,2,1);
histogram(results.rmse_id, 30); xlabel('i_d RMSE (A)'); ylabel('Count');
title('d-axis'); grid on;
subplot(1,2,2);
histogram(results.rmse_iq, 30); xlabel('i_q RMSE (A)');
title('q-axis'); grid on;
end
