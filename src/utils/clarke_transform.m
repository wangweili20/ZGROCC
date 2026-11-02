function x_ab = clarke_transform(x_abc)
x_ab = 2/3*[1, -0.5, -0.5; 0, sqrt(3)/2, -sqrt(3)/2] * x_abc;
end
