function env = mc_perturbation_envelope()
%MC_PERTURBATION_ENVELOPE  Parameter perturbation ranges for Monte Carlo.
env.dRs_range   = [-0.25, 0.25];   % fraction
env.dLd_range   = [-0.15, 0.15];
env.dLq_range   = [-0.15, 0.15];
env.dpsi_range  = [-0.08, 0.08];
env.TL_noise_std = 1.0;            % [N.m]
env.TL_noise_bw  = 200;            % [Hz]
env.Td_set = [1e-6, 2e-6, 3e-6, 4e-6];
end
