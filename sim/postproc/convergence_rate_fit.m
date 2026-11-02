function [alpha_hat, R2] = convergence_rate_fit(Wc_norm_hist, Ts, t_start, t_end)
%CONVERGENCE_RATE_FIT  Estimate empirical convergence exponent.
k1 = round(t_start/Ts); k2 = round(t_end/Ts);
t_vec = (k1:k2)*Ts;
y = log(Wc_norm_hist(k1:k2) + 1e-15);
p = polyfit(t_vec, y, 1);
alpha_hat = -p(1);
y_fit = polyval(p, t_vec);
SS_res = sum((y - y_fit).^2);
SS_tot = sum((y - mean(y)).^2);
R2 = 1 - SS_res/SS_tot;
end
