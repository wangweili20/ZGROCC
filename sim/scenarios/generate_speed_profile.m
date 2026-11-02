function omega = generate_speed_profile(N, Ts, par)
%GENERATE_SPEED_PROFILE  30-s operating cycle: start-accel-cruise-step-decel-reverse.
omega = zeros(1, N);
we_rated = par.omega_e_rated;
t = (0:N-1)*Ts;
for k = 1:N
    if t(k) < 1.0
        omega(k) = we_rated * t(k) / 1.0;
    elseif t(k) < 10.0
        omega(k) = we_rated;
    elseif t(k) < 12.0
        omega(k) = we_rated * 0.3;
    elseif t(k) < 20.0
        omega(k) = we_rated * 0.8;
    elseif t(k) < 22.0
        omega(k) = -we_rated * 0.5;
    else
        omega(k) = we_rated * 0.6;
    end
end
end
