function [J_tracking, J_bound, rho] = dissipation_inequality(e_hist, w_hist, ...
    Q, gamma, P_star, eps_c_bar, lambda_ubar, dt)
%DISSIPATION_INEQUALITY  Evaluate finite-horizon dissipation (Thm 3, eq. 16).
%   int_0^T e'Qe dt  <=  V*(e0) + gamma^2 int_0^T ||w||^2 dt + rho*T
N = size(e_hist,2);
J_tracking = 0;
J_w = 0;
for k = 1:N
    J_tracking = J_tracking + e_hist(:,k)'*Q*e_hist(:,k)*dt;
    J_w = J_w + w_hist(:,k)'*w_hist(:,k)*dt;
end
V0 = e_hist(:,1)'*P_star*e_hist(:,1);
rho = 2.0 * eps_c_bar^2 / lambda_ubar;
T = N*dt;
J_bound = V0 + gamma^2*J_w + rho*T;
end
