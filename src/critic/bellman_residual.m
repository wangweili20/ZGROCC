function [delta_br, sigma, r_val] = bellman_residual(Wc, e, omega_e, de_meas, ...
    u_hat, w_hat, Q, R, gamma)
%BELLMAN_RESIDUAL  Eq (12): temporal difference using measured de/dt.
%   de_meas: finite-differenced state derivative from current samples.
[~, dphi] = critic_basis(e, omega_e);
sigma = dphi' * Wc;
sigma_dot = sigma' * de_meas;
r_val = e'*Q*e + u_hat'*R*u_hat - gamma^2*(w_hat'*w_hat);
delta_br = r_val + sigma_dot;
end
