function [dx, Te] = pmsm_dq_dynamics(x, u, delta, params, omega_e)
%PMSM_DQ_DYNAMICS  Continuous-time dq-frame PMSM model, eqs (1)-(2).
id = x(1); iq = x(2);
ud = u(1); uq = u(2);
dd = delta(1); dq = delta(2);
Rs = params.Rs; Ld = params.Ld; Lq = params.Lq;
psi_f = params.psi_f; pn = params.pn;
did = -Rs/Ld*id + Lq/Ld*omega_e*iq + 1/Ld*(ud + dd);
diq = -Rs/Lq*iq - Ld/Lq*omega_e*id - psi_f/Lq*omega_e + 1/Lq*(uq + dq);
dx = [did; diq];
Te = 1.5*pn*(psi_f*iq + (Ld - Lq)*id*iq);
end
