function results = run_mc_batch(M_rep, T_sim, cfg, env, par_nom, inv)
%RUN_MC_BATCH  Monte Carlo batch: M_rep replications of T_sim seconds.
%   Returns per-replication RMSE, IAE, settling, THD, L2 gain.
rng(42, 'twister');
Ts = cfg.Ts;
N = round(T_sim / Ts);
results.rmse_id = zeros(M_rep,1);
results.rmse_iq = zeros(M_rep,1);
results.iae_id  = zeros(M_rep,1);
results.iae_iq  = zeros(M_rep,1);
results.settle  = zeros(M_rep,1);
results.Wc_err_5s  = zeros(M_rep,1);
results.Wc_err_30s = zeros(M_rep,1);

for rep = 1:M_rep
    par_rep = perturb_params(par_nom, env);
    inv_rep = inv;
    inv_rep.Td = env.Td_set(randi(length(env.Td_set)));
    [e_hist, Wc_hist] = run_single_replication(par_rep, inv_rep, cfg, N, Ts);
    results.rmse_id(rep) = sqrt(mean(e_hist(1,:).^2));
    results.rmse_iq(rep) = sqrt(mean(e_hist(2,:).^2));
    results.iae_id(rep) = Ts * sum(abs(e_hist(1,:)));
    results.iae_iq(rep) = Ts * sum(abs(e_hist(2,:)));
    idx_5s  = min(round(5/Ts), size(Wc_hist,2));
    idx_30s = min(round(30/Ts), size(Wc_hist,2));
    results.Wc_err_5s(rep) = norm(Wc_hist(:,idx_5s));
    results.Wc_err_30s(rep) = norm(Wc_hist(:,idx_30s));
    if mod(rep,20)==0, fprintf('  MC rep %d/%d\n', rep, M_rep); end
end
results.rmse_id_mean = mean(results.rmse_id);
results.rmse_iq_mean = mean(results.rmse_iq);
results.rmse_id_ci95 = 1.96*std(results.rmse_id)/sqrt(M_rep);
results.rmse_iq_ci95 = 1.96*std(results.rmse_iq)/sqrt(M_rep);
end
