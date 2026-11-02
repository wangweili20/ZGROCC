function plot_critic_convergence(Wc_norm_hist, Ts, alpha_c_theory)
%PLOT_CRITIC_CONVERGENCE  Fig 2-3: weight error trajectory + exponential fit.
t = (0:length(Wc_norm_hist)-1)*Ts;
figure; semilogy(t, Wc_norm_hist, 'b-'); hold on;
if nargin >= 3
    semilogy(t, Wc_norm_hist(1)*exp(-alpha_c_theory*t), 'r--');
    legend('Empirical','Theory');
end
xlabel('Time (s)'); ylabel('||W_c - W_c^*||');
grid on;
end
