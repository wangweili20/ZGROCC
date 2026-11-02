function test_deadtime_model()
%TEST_DEADTIME_MODEL  Verify dead-time voltage error sign dependence.
inv = inverter_params();
i_pos = [5; 5; -10];
dv_pos = deadtime_voltage_error(i_pos, inv);
i_neg = [-5; -5; 10];
dv_neg = deadtime_voltage_error(i_neg, inv);
assert(all(sign(dv_pos) ~= sign(dv_neg)), 'Sign dependence broken');
bound = inv_residual_bound(inv);
assert(bound > 0);
fprintf('test_deadtime_model PASSED (delta_bar=%.2f V)\n', bound);
end
