%RUN_GAMMA_SWEEP  Robustness-regret sweep (Table 5).
addpath(genpath(fullfile(fileparts(mfilename('fullpath')),'..')));
par = motor_2p2kW_IPM();
inv = inverter_params();
cfg = zgrocc_tuning();
env = mc_perturbation_envelope();
gamma_vec = [0.20, 0.30, 0.50, 1.0, 5.0, 1e6];
tbl = gamma_sweep(gamma_vec, par, inv, cfg, env, 200, 30);
save('gamma_sweep_results.mat', 'tbl');
