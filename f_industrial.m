function F = f_industrial( q )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    theta = [q(1) q(2) q(3) q(4) q(5) q(6)];
    d = [0.4 0 0 1.0 0 0.25];
    alpha = [pi / 2 0 pi / 2 -pi / 2 90 0];
    a = [0.15 1.2 0.1 0 0 0];
    
    A1 = a_matrix(theta(1), d(1), alpha(1), a(1));
    A2 = a_matrix(theta(2), d(2), alpha(2), a(2));
    A3 = a_matrix(theta(3), d(3), alpha(3), a(3));
    A4 = a_matrix(theta(4), d(4), alpha(4), a(4));
    A5 = a_matrix(theta(5), d(5), alpha(5), a(5));
    A6 = a_matrix(theta(6), d(6), alpha(6), a(6));
    
    A60 = A1 * A2 * A3 * A4 * A5 * A6;
    H60 = [0 0 1 0.5; 0 -1 0 1.75 ; 1 0 0 0.8; 0 0 0 1];
    
    F = A60(1:3, :) - H60(1:3, :);
end

function A = a_matrix(theta, d, alpha, a)
    A_a = [cos(theta) -sin(theta) 0 0; ...
        sin(theta) cos(theta) 0 0; ...
        0 0 1 d; ...
        0 0 0 1];
    A_b = [1 0 0 a; ...
        0 cos(alpha) -sin(alpha) 0; ...
        0 sin(alpha) cos(alpha) 0; ...
        0 0 0 1];
    A = A_a * A_b;
end