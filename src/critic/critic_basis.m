function [phi, dphi_de] = critic_basis(e, omega_e)
%CRITIC_BASIS  Quadratic + speed-augmented critic basis, eq (9).
%   phi = [ed^2, ed*eq, eq^2, we*ed^2, we*ed*eq, we*eq^2]'
%   dphi_de: Jacobian w.r.t. e  (6 x 2)
ed = e(1); eq = e(2);
phi = [ed^2; ed*eq; eq^2; omega_e*ed^2; omega_e*ed*eq; omega_e*eq^2];
dphi_de = [2*ed, 0;
           eq, ed;
           0, 2*eq;
           2*omega_e*ed, 0;
           omega_e*eq, omega_e*ed;
           0, 2*omega_e*eq];
end
