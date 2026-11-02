function [e_hist, Wc_tilde_hist] = run_single_replication(par, inv, cfg, N, Ts)
%RUN_SINGLE_REPLICATION  One 30-s cycle: startup, accel, cruise, steps, reversal.
B  = diag([1/par.Ld, 1/par.Lq]);
Bw = [B, B];
A0 = [-par.Rs/par.Ld, 0; 0, -par.Rs/par.Lq];
[P0, ~, ~] = zsg_hjieq(A0, B, Bw, cfg.Q, cfg.R, cfg.gamma);
Wc_star = symmat_to_vec6(P0);
Wc = Wc_star + 0.3*randn(cfg.nc, 1);
buffer = svmax_buffer_init(cfg.nc, cfg.M);
x = [0;0];
e_hist = zeros(2, N);
Wc_tilde_hist = zeros(cfg.nc, N);
omega_profile = generate_speed_profile(N, Ts, par);
iref_profile  = generate_current_ref(N, Ts, par);
e_prev = [0;0];
for k = 1:N
    omega_e = omega_profile(k);
    x_ref = iref_profile(:,k);
    e = x - x_ref;
    [u_hat, w_hat] = actor_disturbance_policy(Wc, e, omega_e, B, Bw, cfg.R, cfg.gamma);
    u_ff = pmsm_feedforward(x_ref, [0;0], par, omega_e);
    u_total = u_ff + u_hat;
    [u_sat, sat_flag] = voltage_saturation(u_total, inv.Vdc);
    i_abc = inv_park_transform(x, omega_e * k * Ts);
    delta_inv = park_deadtime_residual(i_abc, omega_e*k*Ts, inv);
    w_ext = cfg.eta_c*0.01*randn(2,1);
    w = [w_ext; delta_inv];
    delta = B * (u_sat - u_total) + Bw * w;
    x = pmsm_rk4_step(x, u_sat, delta_inv + w_ext, par, omega_e, Ts);
    de_meas = (e - e_prev) / Ts;
    [~, sigma, r_val] = bellman_residual(Wc, e, omega_e, de_meas, u_hat, w_hat, ...
        cfg.Q, cfg.R, cfg.gamma);
    buffer = svmax_buffer_update(buffer, sigma, r_val);
    Wc = concurrent_learning_update(Wc, sigma, r_val, buffer, cfg.eta_c, sat_flag);
    e_hist(:,k) = e;
    Wc_tilde_hist(:,k) = Wc - Wc_star;
    e_prev = e;
end
end
