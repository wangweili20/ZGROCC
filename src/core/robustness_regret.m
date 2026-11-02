function [RR, C1] = robustness_regret(P_inf, P_gamma, B, Bw, Q, R, gamma)
%ROBUSTNESS_REGRET  Prop. 3: RR(gamma) <= C1/gamma^2 * tr(P_inf Bw Bw' P_inf).
%   P_inf: LQR Riccati solution (gamma -> inf)
%   P_gamma: ZSG Riccati solution at finite gamma
dP = P_gamma - P_inf;
K_inf = R \ (B'*P_inf);
K_gam = R \ (B'*P_gamma);
RR = trace(dP * (Q + K_gam'*R*K_gam)) - trace(P_inf*(Q + K_inf'*R*K_inf));
RR = max(RR, 0);
C1 = gamma^2 * RR / max(trace(P_inf * Bw * Bw' * P_inf), 1e-15);
end
