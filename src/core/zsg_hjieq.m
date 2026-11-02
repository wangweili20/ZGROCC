function [P_star, K_u, K_w, gamma_star] = zsg_hjieq(A, B, Bw, Q, R, gamma, opts)
%ZSG_HJIEQ  Parameter-dependent H-infinity ARE for the dq-frame ZSG.
%
%   A'P + PA + Q - P*B*inv(R)*B'*P + (1/gamma^2)*P*Bw*Bw'*P = 0

if nargin < 7, opts = struct(); end
if ~isfield(opts,'tol'), opts.tol = 1e-12; end

n = size(A,1);
As = 0.5*(A + A');
sig_min_As = min(abs(eig(As)));
gamma_star = norm(Bw)*norm(Q^0.5) / (sig_min_As * sqrt(min(eig(R))));

if gamma <= gamma_star
    warning('zsg_hjieq:playability', ...
        'gamma=%.4f <= gamma*=%.4f', gamma, gamma_star);
end

S_u = B * (R \ B');
S_w = (1/gamma^2) * (Bw * Bw');
H = [A, -(S_u - S_w); -Q, -A'];

[V, D] = eig(H);
d = diag(D);
idx_stable = find(real(d) < -opts.tol);
if length(idx_stable) ~= n
    error('zsg_hjieq:hamiltonian', ...
        'Stable eigenspace dim = %d, expected %d.', length(idx_stable), n);
end

V_s = V(:, idx_stable);
P_star = real(V_s(n+1:end, :) / V_s(1:n, :));
P_star = 0.5*(P_star + P_star');

K_u = R \ (B' * P_star);
K_w = (1/gamma^2) * (Bw' * P_star);

Acl = A - B*K_u + Bw*K_w;
if any(real(eig(Acl)) >= 0)
    warning('zsg_hjieq:stability', 'Acl not Hurwitz.');
end
end
