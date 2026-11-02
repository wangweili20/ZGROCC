function [id, iq] = park_transform_f32(ia, ib, ic, theta)
id = 2/3*(ia*cos(theta) + ib*cos(theta-2*pi/3) + ic*cos(theta+2*pi/3));
iq = -2/3*(ia*sin(theta) + ib*sin(theta-2*pi/3) + ic*sin(theta+2*pi/3));
end
