function test_playability()
%TEST_PLAYABILITY  Verify Prop 1 bound against numerical sweep.
par = motor_2p2kW_IPM();
cfg = zgrocc_tuning();
[gs_formula] = playability_bound(par, cfg.Q, cfg.R);
B = diag([1/par.Ld, 1/par.Lq]);
Bw = [B, B];
gamma_test = linspace(0.05, 1.0, 200);
gs_numerical = nan;
for g = 1:length(gamma_test)
    A = [-par.Rs/par.Ld, (par.Lq/par.Ld)*par.omega_e_rated;
         -(par.Ld/par.Lq)*par.omega_e_rated, -par.Rs/par.Lq];
    try
        [P] = zsg_hjieq(A, B, Bw, cfg.Q, cfg.R, gamma_test(g));
        if all(eig(P) > 0), gs_numerical = gamma_test(g); break; end
    catch
    end
end
fprintf('gamma* formula = %.4f, numerical = %.4f\n', gs_formula, gs_numerical);
assert(gs_formula >= gs_numerical, 'Formula bound not conservative');
fprintf('test_playability PASSED\n');
end
