function tbl = gamma_sweep(gamma_vec, par, inv, cfg, env, M_rep, T_sim)
%GAMMA_SWEEP  Robustness-regret trade-off (Table 5).
tbl.gamma = gamma_vec;
tbl.nom_cost = zeros(size(gamma_vec));
tbl.wc_cost  = zeros(size(gamma_vec));
tbl.RR_pct   = zeros(size(gamma_vec));
for g = 1:length(gamma_vec)
    cfg_g = cfg;
    cfg_g.gamma = gamma_vec(g);
    res = run_mc_batch(M_rep, T_sim, cfg_g, env, par, inv);
    tbl.nom_cost(g) = mean(res.rmse_iq);
    tbl.wc_cost(g)  = max(res.rmse_iq);
end
tbl.RR_pct = 100*(tbl.nom_cost / tbl.nom_cost(end) - 1);
end
