function par = perturb_params(par_nom, env)
%PERTURB_PARAMS  Draw random parameter perturbation for one MC replication.
par = par_nom;
par.Rs = par_nom.Rs * (1 + env.dRs_range(1) + diff(env.dRs_range)*rand);
par.Ld = par_nom.Ld * (1 + env.dLd_range(1) + diff(env.dLd_range)*rand);
par.Lq = par_nom.Lq * (1 + env.dLq_range(1) + diff(env.dLq_range)*rand);
par.psi_f = par_nom.psi_f * (1 + env.dpsi_range(1) + diff(env.dpsi_range)*rand);
end
