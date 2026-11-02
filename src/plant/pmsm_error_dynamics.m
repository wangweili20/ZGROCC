function [de, A_we, eta] = pmsm_error_dynamics(e, u_tilde, w, params, omega_e, xref, dxref)
%PMSM_ERROR_DYNAMICS  Tracking error dynamics, eq (3).
Rs = params.Rs; Ld = params.Ld; Lq = params.Lq;
psi_f = params.psi_f;
A_we = [-Rs/Ld, (Lq/Ld)*omega_e; -(Ld/Lq)*omega_e, -Rs/Lq];
B = diag([1/Ld, 1/Lq]);
Bw = [B, B];
eta = -dxref + [Lq/Ld*omega_e*xref(2); ...
    -Ld/Lq*omega_e*xref(1) - psi_f/Lq*omega_e] ...
    - A_we*xref;
de = A_we*e + B*u_tilde + Bw*w + eta;
end
