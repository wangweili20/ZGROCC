function [u_sat, is_saturated] = voltage_saturation(u, Vdc)
%VOLTAGE_SATURATION  Magnitude-preserving saturation for SVPWM linear region.
u_max = Vdc / sqrt(3);
u_mag = norm(u);
if u_mag > u_max
    u_sat = u * (u_max / u_mag);
    is_saturated = true;
else
    u_sat = u;
    is_saturated = false;
end
end
