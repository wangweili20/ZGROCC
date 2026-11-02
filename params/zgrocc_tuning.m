function cfg = zgrocc_tuning()
%ZGROCC_TUNING  Controller tuning parameters (Table 11 in manuscript).
cfg.Q     = diag([500, 500]);
cfg.R     = diag([0.1, 0.1]);
cfg.gamma = 0.30;
cfg.eta_c = 0.5;
cfg.M     = 30;
cfg.nc    = 6;
cfg.Ts    = 100e-6;   % current-loop sampling period [s]
cfg.Wc0_source = 'offline_ARE_omega0';
end
