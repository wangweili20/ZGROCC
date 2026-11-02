function [u_hat, w_hat] = actor_disturbance_policy(Wc, e, omega_e, B, Bw, R, gamma)
%ACTOR_DISTURBANCE_POLICY  Eqs (10)-(11): saddle-point pair from critic.
[~, dphi] = critic_basis(e, omega_e);
grad_V = dphi' * Wc;
u_hat = -0.5 * (R \ (B' * grad_V));
w_hat =  0.5 / gamma^2 * (Bw' * grad_V);
end
