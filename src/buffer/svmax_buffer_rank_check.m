function [is_full_rank, lmin] = svmax_buffer_rank_check(buffer, lambda_threshold)
%SVMAX_BUFFER_RANK_CHECK  Verify Assumption A2 online.
if nargin < 2, lambda_threshold = 0.01; end
if buffer.count < size(buffer.sigma, 1)
    is_full_rank = false;
    lmin = 0;
else
    lmin = min(eig(buffer.Sigma_sum));
    is_full_rank = (lmin >= lambda_threshold);
end
end
