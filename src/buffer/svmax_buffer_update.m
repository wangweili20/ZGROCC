function buffer = svmax_buffer_update(buffer, sigma_new, r_new)
%SVMAX_BUFFER_UPDATE  Singular-value maximisation rule for buffer management.
%   Maintains lambda_min(sum sigma_k sigma_k') >= underline{lambda}.
nc = size(sigma_new, 1);
M = buffer.M;

if buffer.count < M
    buffer.count = buffer.count + 1;
    buffer.sigma(:, buffer.count) = sigma_new;
    buffer.r(buffer.count) = r_new;
    buffer.Sigma_sum = buffer.Sigma_sum + sigma_new * sigma_new';
else
    Sigma_candidate = buffer.Sigma_sum + sigma_new * sigma_new';
    best_lmin = -inf;
    best_j = -1;
    for j = 1:M
        sj = buffer.sigma(:,j);
        Sigma_trial = Sigma_candidate - sj * sj';
        lmin_trial = min(eig(Sigma_trial));
        if lmin_trial > best_lmin
            best_lmin = lmin_trial;
            best_j = j;
        end
    end
    lmin_current = min(eig(buffer.Sigma_sum));
    if best_lmin > lmin_current
        old_s = buffer.sigma(:, best_j);
        buffer.Sigma_sum = buffer.Sigma_sum - old_s*old_s' + sigma_new*sigma_new';
        buffer.sigma(:, best_j) = sigma_new;
        buffer.r(best_j) = r_new;
    end
end
buffer.lambda_min_hist(end+1) = min(eig(buffer.Sigma_sum));
end
