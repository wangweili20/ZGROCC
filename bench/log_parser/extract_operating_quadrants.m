function [quad_idx, quad_labels] = extract_operating_quadrants(omega_e, iq, id, params)
%EXTRACT_OPERATING_QUADRANTS  Classify samples into Table 8 quadrants.
N = length(omega_e);
quad_idx = zeros(N,1);
quad_labels = {'low_speed_motoring','low_speed_regen','high_speed_motoring','high_speed_fw'};
omega_thresh = 0.3 * params.omega_e_rated;
for k = 1:N
    is_low = abs(omega_e(k)) < omega_thresh;
    is_motoring = omega_e(k)*iq(k) >= 0;
    is_fw = abs(id(k)) > 0.1 * params.I_rated;
    if is_low && is_motoring
        quad_idx(k) = 1;
    elseif is_low && ~is_motoring
        quad_idx(k) = 2;
    elseif ~is_low && ~is_fw
        quad_idx(k) = 3;
    else
        quad_idx(k) = 4;
    end
end
end
