function p = motor_2p2kW_IPM()
%MOTOR_2P2KW_IPM  Nominal parameters for the 2.2 kW benchmark IPM.
p.Rs    = 0.96;       % stator resistance [Ohm]
p.Ld    = 4.4e-3;     % d-axis inductance [H]
p.Lq    = 6.8e-3;     % q-axis inductance [H]
p.psi_f = 0.176;      % PM flux linkage [Wb]
p.pn    = 4;          % pole pairs
p.J     = 0.0018;     % rotor inertia [kg.m^2]
p.Bm    = 0.0002;     % viscous friction [N.m.s/rad]
p.I_rated = 11;       % rated current [A]
p.T_rated = 7;        % rated torque [N.m]
p.n_rated = 3000;     % rated speed [rpm]
p.omega_e_rated = p.n_rated*2*pi/60*p.pn;  % rated elec. speed [rad/s]
end
