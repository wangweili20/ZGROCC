function eta_eff = aw_critic_rate(eta_c, is_saturated)
%AW_CRITIC_RATE  Anti-windup learning rate reduction.
if is_saturated
    eta_eff = eta_c * 0.5;
else
    eta_eff = eta_c;
end
end
