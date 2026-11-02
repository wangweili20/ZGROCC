function delta_bar = inv_residual_bound(inv_params)
%INV_RESIDUAL_BOUND  Worst-case ||delta_inv||_inf bound.
Td = inv_params.Td; Ts_sw = inv_params.Ts_sw;
Vdc = inv_params.Vdc; Vce = inv_params.Vce; Vd = inv_params.Vd;
Ton = inv_params.Ton; Toff = inv_params.Toff;
v_dt = (Td + Ton - Toff)/Ts_sw * Vdc + 0.5*(Vce - Vd);
delta_bar = 2/3 * 2 * (v_dt + 0.5*(Vce + Vd));
end
