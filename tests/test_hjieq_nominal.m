function test_hjieq_nominal()
%TEST_HJIEQ_NOMINAL  Verify ARE solution at nominal operating point.
par = motor_2p2kW_IPM();
cfg = zgrocc_tuning();
B = diag([1/par.Ld, 1/par.Lq]);
Bw = [B, B];
A0 = [-par.Rs/par.Ld, 0; 0, -par.Rs/par.Lq];
[P, Ku, Kw, gs] = zsg_hjieq(A0, B, Bw, cfg.Q, cfg.R, cfg.gamma);
assert(all(eig(P) > 0), 'P not positive definite');
Acl = A0 - B*Ku + Bw*Kw;
assert(all(real(eig(Acl)) < 0), 'Acl not Hurwitz');
residual = A0'*P + P*A0 + cfg.Q - P*B*(cfg.R\B')*P + (1/cfg.gamma^2)*P*Bw*Bw'*P;
assert(norm(residual,'fro') < 1e-8, 'ARE residual too large');
fprintf('test_hjieq_nominal PASSED (gamma*=%.4f)\n', gs);
end
