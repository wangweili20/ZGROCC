function [va, vb, vc] = inv_park_f32(vd, vq, theta)
va = vd*cos(theta) - vq*sin(theta);
vb = vd*cos(theta-2*pi/3) - vq*sin(theta-2*pi/3);
vc = vd*cos(theta+2*pi/3) - vq*sin(theta+2*pi/3);
end
