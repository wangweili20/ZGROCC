function [V_hat, grad_V] = critic_eval(Wc, e, omega_e)
%CRITIC_EVAL  Evaluate critic value and its gradient w.r.t. e.
[phi, dphi] = critic_basis(e, omega_e);
V_hat = Wc' * phi;
grad_V = dphi' * Wc;
end
