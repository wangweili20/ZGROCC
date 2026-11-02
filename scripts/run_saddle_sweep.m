%RUN_SADDLE_SWEEP  Sweep omega_e for P*(omega_e) smoothness (Thm 1(ii)).
addpath(genpath(fullfile(fileparts(mfilename('fullpath')),'..')));
par = motor_2p2kW_IPM();
cfg = zgrocc_tuning();
omega_vec = linspace(-par.omega_e_rated, par.omega_e_rated, 500);
res = zsg_saddle_sweep(par, omega_vec, cfg.Q, cfg.R, cfg.gamma);
save('saddle_sweep.mat', 'res');
