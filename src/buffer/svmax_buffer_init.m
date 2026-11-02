function buffer = svmax_buffer_init(nc, M)
%SVMAX_BUFFER_INIT  Initialise concurrent-learning data buffer.
buffer.sigma = zeros(nc, M);
buffer.r     = zeros(1, M);
buffer.count = 0;
buffer.M     = M;
buffer.Sigma_sum = zeros(nc, nc);
buffer.lambda_min_hist = [];
end
