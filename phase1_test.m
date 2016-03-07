H60_start = [1 0 0 -0.25; 0 -1 0 1.5; 0 0 -1 1.25; 0 0 0 1];
H60_end = [0 0 1 0.5; 0 -1 0 1.75; 1 0 0 0.8; 0 0 0 1];

options = optimset('Algorithm', 'levenberg-marquardt', 'Display', 'off');

d1 = 0.4;
a1 = 0.15;
a2 = 1.2;
a3 = 0.1;
d4 = 1.0;
d6 = 0.25;

theta_start = inverse_k(H60_start, d1, a1, a2, a3, d4, d6) * 180 / pi;
theta_end = inverse_k(H60_end, d1, a1, a2, a3, d4, d6) * 180 / pi;

% The notation here 'p10' denotes position of start frame wrt base
% Notation 'p20' denotes position of end frame wrt base
p10 = H60_start(1:3, 4);
p20 = H60_end(1:3, 4);
R10 = H60_start(1:3, 1:3);
R20 = H60_end(1:3, 1:3);

delta_p = p20 - p10;
R21 = R10' * R20;

p = zeros(3, 10);
phi_vals = zeros(1, 10);

[phi, k] = k_phi(R21);
K = [0 -k(3) k(2); k(3) 0 -k(1); -k(2) k(1) 0];
I = eye(3);

for i = 1:10
   p(:, i) = p10 + delta_p * i / 10;
   phi_vals(i) = i / 10 * phi;
   R = I + K * sin(phi_vals(i)) + K^2 * (1 - cos(phi_vals(i)));
   R = R10 * R;
   H = zeros(4);
   H(1:3, 1:3) = R;
   H(1:3, 4) = p(1:3, i);
   H(4,4) = 1;
end

q_end = fsolve(@f_industrial, theta_start * pi / 180, options)