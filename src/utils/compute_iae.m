function iae = compute_iae(e_hist, Ts)
%COMPUTE_IAE  Ts * sum(|e_j|) per channel.
iae = Ts * sum(abs(e_hist), 2);
end
