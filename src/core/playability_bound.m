function [gamma_star, sig] = playability_bound(params, Q, R, Bw)
%PLAYABILITY_BOUND  Prop. 1 formula for gamma* from motor datasheet.
Rs = params.Rs; Ld = params.Ld; Lq = params.Lq;
sig = Rs / max(Ld, Lq);
if nargin < 4
    B = diag([1/Ld, 1/Lq]);
    Bw = [B, B];
end
gamma_star = norm(Bw)*norm(sqrtm(Q)) / (sig*sqrt(min(eig(R))));
end
