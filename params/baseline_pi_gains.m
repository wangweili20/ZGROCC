function gains = baseline_pi_gains()
%BASELINE_PI_GAINS  Ziegler-Nichols tuned PI for the 2.2 kW benchmark.
gains.Kp_d = 22.0;
gains.Ki_d = 4400;
gains.Kp_q = 34.0;
gains.Ki_q = 6800;
gains.Ts = 100e-6;
end
