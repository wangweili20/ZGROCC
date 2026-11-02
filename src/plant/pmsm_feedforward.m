function u_ff = pmsm_feedforward(xref, dxref, params, omega_e)
%PMSM_FEEDFORWARD  Compute state feedforward u_ff from (omega_e, x*, dx*).
Rs = params.Rs; Ld = params.Ld; Lq = params.Lq;
psi_f = params.psi_f;
u_ff_d = Ld*dxref(1) + Rs*xref(1) - Lq*omega_e*xref(2);
u_ff_q = Lq*dxref(2) + Rs*xref(2) + Ld*omega_e*xref(1) + psi_f*omega_e;
u_ff = [u_ff_d; u_ff_q];
end
