function test_voltage_saturation()
%TEST_VOLTAGE_SATURATION  Verify magnitude-preserving clipping.
Vdc = 540;
u_inside = [100; 200];
[u_s, s] = voltage_saturation(u_inside, Vdc);
assert(~s, 'Should not saturate');
assert(norm(u_s - u_inside) < 1e-10);
u_outside = [400; 400];
[u_s, s] = voltage_saturation(u_outside, Vdc);
assert(s, 'Should saturate');
assert(abs(norm(u_s) - Vdc/sqrt(3)) < 1e-6);
assert(abs(u_s(1)/u_s(2) - 1) < 1e-10, 'Direction not preserved');
fprintf('test_voltage_saturation PASSED\n');
end
