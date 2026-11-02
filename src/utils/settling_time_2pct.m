function t_s = settling_time_2pct(response, ref_final, Ts)
%SETTLING_TIME_2PCT  2% criterion settling time.
tol = 0.02 * abs(ref_final);
N = length(response);
t_s = N * Ts;
for k = N:-1:1
    if abs(response(k) - ref_final) > tol
        t_s = k * Ts;
        break;
    end
end
end
