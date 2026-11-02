function x_next = pmsm_rk4_step(x, u, delta, params, omega_e, dt)
%PMSM_RK4_STEP  Fourth-order Runge-Kutta integrator for dq dynamics.
f = @(s) pmsm_dq_dynamics(s, u, delta, params, omega_e);
k1 = f(x);
k2 = f(x + 0.5*dt*k1);
k3 = f(x + 0.5*dt*k2);
k4 = f(x + dt*k3);
x_next = x + dt/6*(k1 + 2*k2 + 2*k3 + k4);
end
