function dv = deadtime_voltage_error(i_phase, inv_params)
%DEADTIME_VOLTAGE_ERROR  Eq (20): phase voltage error from dead time + device drop.
Td = inv_params.Td; Ts_sw = inv_params.Ts_sw;
Vdc = inv_params.Vdc; Vce = inv_params.Vce; Vd = inv_params.Vd;
Ton = inv_params.Ton; Toff = inv_params.Toff;
dv = zeros(size(i_phase));
for j = 1:length(i_phase)
    dv(j) = -sign(i_phase(j)) * ((Td + Ton - Toff)/Ts_sw * Vdc + 0.5*(Vce - Vd)) ...
             + 0.5*(Vce + Vd);
end
end
