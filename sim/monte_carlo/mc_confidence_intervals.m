function [mu, ci_lo, ci_hi] = mc_confidence_intervals(data, alpha)
%MC_CONFIDENCE_INTERVALS  Mean and symmetric CI at level alpha.
if nargin < 2, alpha = 0.05; end
M = length(data);
mu = mean(data);
se = std(data)/sqrt(M);
z = norminv(1 - alpha/2);
ci_lo = mu - z*se;
ci_hi = mu + z*se;
end
