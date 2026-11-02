function delta_inv = park_deadtime_residual(i_abc, theta_e, inv_params)
%PARK_DEADTIME_RESIDUAL  Transform phase voltage errors to dq frame.
dv_abc = deadtime_voltage_error(i_abc, inv_params);
cos_t = cos(theta_e); sin_t = sin(theta_e);
cos_t2 = cos(theta_e - 2*pi/3); sin_t2 = sin(theta_e - 2*pi/3);
cos_t3 = cos(theta_e + 2*pi/3); sin_t3 = sin(theta_e + 2*pi/3);
T_park = 2/3 * [cos_t, cos_t2, cos_t3; -sin_t, -sin_t2, -sin_t3];
delta_inv = T_park * dv_abc;
end
