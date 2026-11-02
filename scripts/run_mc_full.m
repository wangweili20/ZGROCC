%RUN_MC_FULL  Full Monte Carlo experiment (Table 2, Fig 1).
addpath(genpath(fullfile(fileparts(mfilename('fullpath')),'..')));
par = motor_2p2kW_IPM();
inv = inverter_params();
cfg = zgrocc_tuning();
env = mc_perturbation_envelope();
M_rep = 200;
T_sim = 30;
fprintf('Starting MC batch: M=%d, T=%.0f s\n', M_rep, T_sim);
tic;
res = run_mc_batch(M_rep, T_sim, cfg, env, par, inv);
t_elapsed = toc;
fprintf('MC completed in %.1f s\n', t_elapsed);
fprintf('iq RMSE: %.3f +/- %.3f\n', res.rmse_iq_mean, res.rmse_iq_ci95);
save('mc_results.mat', 'res');
