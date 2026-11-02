%RUN_ABLATION  Ablation study (Table 10).
addpath(genpath(fullfile(fileparts(mfilename('fullpath')),'..')));
par = motor_2p2kW_IPM();
inv = inverter_params();
cfg = zgrocc_tuning();
env = mc_perturbation_envelope();
configs = {'pi_baseline','pi_dtff','lqr_offline','hinf_offline', ...
           'hinf_fixed_bound_adp','adp_no_cl','zgrocc_full'};
for c = 1:length(configs)
    fprintf('Ablation: %s\n', configs{c});
end
