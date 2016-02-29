function [ theta ] = inverse_k( H60, d1, a1, a2, a3, d4, d6 )
% Input the combined translation matrix for frame 6 with respect to frame
% 0, in addition to the d1, a1, a2, a3, d4, d6 values from the DH table.
% Returns a 1x6 vector with the different angles of theta necessary to
% achieve that combined translation matrix.
    
    p60 = H60(1:3, 4);
    p50 = p60 - d6 * H60(1:3, 3);
    
    x = p50(1);
    y = p50(2);
    z = p50(3);
    
    theta1 = atan2(y, x);
    
    eta_x = sqrt(x^2 + y^2);
    eta_z = z - d1;
    d4_tilde = sqrt(a3^2 + d4^2);
    
    s3_tilde = (eta_x^2 + eta_z^2 - d4_tilde^2 - a2^2) / (2 * a2 * d4_tilde);
    c3_tilde = sqrt(1 - s3_tilde^2);
    theta3_tilde = atan2(s3_tilde, c3_tilde);
    
    theta3 = theta3_tilde - atan(a3 / d4);
    theta2 = atan2(eta_x * d4_tilde * c3_tilde + eta_z * (d4_tilde * s3_tilde + a2), ...
        eta_x * (d4_tilde * s3_tilde + a2) - eta_z * d4_tilde * c3_tilde);
    
    R03 = [cos(theta1) * cos(theta2 + theta3) sin(theta1) * cos(theta2 + theta3) sin(theta2 + theta3); ...
        sin(theta1) -cos(theta1) 0; ...
        cos(theta1) * sin(theta2 + theta3) sin(theta1) * sin(theta2 + theta3) -cos(theta2 + theta3)];
    R60 = H60(1:3, 1:3);
    rho = R03 * R60;
    
    theta4 = atan(rho(2, 3) / rho(1, 3));
    theta5 = atan2(cos(theta4) * rho(1, 3) + sin(theta4) * rho(2, 3), ...
        -rho(3, 3));
    theta6 = atan2(sin(theta4) * rho(1, 1) - cos(theta4) * rho(2, 1), ...
        sin(theta4) * rho(1, 2) - cos(theta4) * rho(2, 2));
    
    theta = [theta1 theta2 theta3 theta4 theta5 theta6];
    
end

