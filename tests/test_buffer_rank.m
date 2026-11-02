function test_buffer_rank()
%TEST_BUFFER_RANK  Verify buffer achieves full rank after diverse excitation.
buf = svmax_buffer_init(6, 30);
rng(7);
for k = 1:100
    sig = randn(6,1)*0.5;
    r = randn;
    buf = svmax_buffer_update(buf, sig, r);
end
[ok, lmin] = svmax_buffer_rank_check(buf, 0.01);
assert(ok, 'Buffer not full rank');
fprintf('test_buffer_rank PASSED (lambda_min=%.4f)\n', lmin);
end
