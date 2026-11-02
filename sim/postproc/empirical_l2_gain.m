function l2g = empirical_l2_gain(e_hist, w_hist, Q, Ts)
%EMPIRICAL_L2_GAIN  Ratio of regulated output energy to disturbance energy.
E_out = Ts * sum(sum((sqrtm(Q)*e_hist).^2, 1));
E_in  = Ts * sum(sum(w_hist.^2, 1));
l2g = sqrt(E_out / max(E_in, 1e-15));
end
