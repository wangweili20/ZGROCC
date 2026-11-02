function x_abc = inv_park_transform(x_dq, theta_e)
ct = cos(theta_e); st = sin(theta_e);
T_inv = [ct, -st; cos(theta_e-2*pi/3), -sin(theta_e-2*pi/3);
         cos(theta_e+2*pi/3), -sin(theta_e+2*pi/3)];
x_abc = T_inv * x_dq;
end
