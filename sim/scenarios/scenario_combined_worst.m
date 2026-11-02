function [par, inv] = scenario_combined_worst(par_nom, inv_base)
%SCENARIO_COMBINED_WORST  Simultaneous worst-case: +25% Rs, +15% Ld/Lq, -8% psi, Td=4us.
par = par_nom;
par.Rs = par_nom.Rs * 1.25;
par.Ld = par_nom.Ld * 1.15;
par.Lq = par_nom.Lq * 1.15;
par.psi_f = par_nom.psi_f * 0.92;
inv = inv_base;
inv.Td = 4e-6;
end
