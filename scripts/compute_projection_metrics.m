%COMPUTE_PROJECTION_METRICS  Table 10 practical impact projection.
%   Bearing fatigue: Palmgren-Miner linear damage accumulation.
%   Efficiency:      delta_Pcu = 3*Rs*(delta_Irms)^2
addpath(genpath(fullfile(fileparts(mfilename('fullpath')),'..')));
par = motor_2p2kW_IPM();
I_rms_pi = 0.452;
I_rms_zg = 0.232;
delta_Pcu = 3 * par.Rs * (I_rms_pi^2 - I_rms_zg^2);
hours_per_year = 5600;
energy_kWh = delta_Pcu * hours_per_year / 1000;
fprintf('Copper loss reduction: %.1f W\n', delta_Pcu);
fprintf('Annual energy saving: %.0f kWh\n', energy_kWh);
