H60_start = [1 0 0 -0.25; 0 -1 0 1.5; 0 0 -1 1.25; 0 0 0 1];
H60_end = [0 0 1 0.5; 0 -1 0 1.75; 1 0 0 0.8; 0 0 0 1];

d1 = 0.4;
a1 = 0.15;
a2 = 1.2;
a3 = 0.1;
d4 = 1.0;
d6 = 0.25;

theta_start = inverse_k(H60_start, d1, a1, a2, a3, d4, d6) * 180 / pi
theta_end = inverse_k(H60_end, d1, a1, a2, a3, d4, d6) * 180 / pi