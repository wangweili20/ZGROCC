function [Wc_new, eta_eff] = concurrent_learning_update(Wc, sigma, r_val, ...
    buffer, eta_c, is_saturated)
%CONCURRENT_LEARNING_UPDATE  Eq (13): gradient + buffer sum.
%   Anti-windup: halve learning rate when voltage saturation is active.
if is_saturated
    eta_eff = eta_c * 0.5;
else
    eta_eff = eta_c;
end
norm_s2 = sigma'*sigma;
dW_inst = -eta_eff * sigma * (sigma'*Wc + r_val) / (1 + norm_s2)^2;
dW_buf = zeros(size(Wc));
M = buffer.count;
for k = 1:M
    sk = buffer.sigma(:,k);
    rk = buffer.r(k);
    ns2 = sk'*sk;
    dW_buf = dW_buf - eta_eff * sk * (sk'*Wc + rk) / (1 + ns2)^2;
end
Wc_new = Wc + (dW_inst + dW_buf);
end
