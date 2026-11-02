function rmse = compute_rmse(e_hist, Ts)
%COMPUTE_RMSE  sqrt(1/N * sum(e_j^2)) per channel.
N = size(e_hist, 2);
rmse = sqrt(sum(e_hist.^2, 2) / N);
end
