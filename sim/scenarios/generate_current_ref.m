function iref = generate_current_ref(N, Ts, par)
%GENERATE_CURRENT_REF  dq current reference trajectory.
iref = zeros(2, N);
t = (0:N-1)*Ts;
for k = 1:N
    iref(1,k) = 0;
    if t(k) < 1.0
        iref(2,k) = par.I_rated * t(k);
    elseif t(k) < 10.0
        iref(2,k) = par.I_rated;
    elseif t(k) < 12.0
        iref(2,k) = par.I_rated * 0.5;
    elseif t(k) < 15.0
        iref(2,k) = par.I_rated;
    elseif t(k) < 17.0
        iref(2,k) = par.I_rated * 0.3;
    else
        iref(2,k) = par.I_rated * 0.7;
    end
end
end
