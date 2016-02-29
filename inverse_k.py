from numpy import arctan2 as atan2
from numpy import arctan as atan
from numpy import matrix, sin, cos, pi, sqrt

def inverse_k(H60, d1, a1, a2, a3, d4, d6):
    
    p60 = H60[:3, 3]
    p50 = p60 - d6 * H60[:3, 2]
    
    x, y, z = p50
    theta1 = atan2(y, x)
    
    eta_x = sqrt(x**2 + y**2) - a1
    eta_z = z - d1

    d4_tilde = sqrt(a3**2 + d4**2)

    s3_tilde = (eta_x**2 + eta_z**2 - d4**2 - a2**2) / (2 * a2 * d4_tilde)
    c3_tilde = sqrt(1 - s3_tilde**2)

    theta3_tilde = atan2(s3_tilde, c3_tilde)
    theta3 = theta3_tilde - atan(a3 / d4)

    theta2 = atan2(eta_x * d4_tilde * c3_tilde + eta_z * (d4_tilde * s3_tilde + a2),
            eta_x * (d4_tilde * s3_tilde + a2) - eta_z * d4_tilde * c3_tilde)

    R03 = matrix([[cos(theta1) * cos(theta2 + theta3), sin(theta1) * cos(theta2 + theta3), sin(theta2 + theta3)],
        [sin(theta1), -cos(theta1), 0],
        [cos(theta1) * sin(theta2 + theta3), sin(theta1) * sin(theta2 + theta3), -cos(theta2 + theta3)]])

    rho = R03 * H60[:3, :3]

    theta4 = atan(rho[1, 2] / rho[0, 2])
    theta5 = atan2(cos(theta4) * rho[0, 2] + sin(theta4) * rho[1, 2],
            -rho[2, 2])
    theta6 = atan2(sin(theta4) * rho[0, 0] - cos(theta4) * rho[1, 0],
            sin(theta4) * rho[0, 1] - cos(theta4) * rho[1, 1])

    return [theta1,
            theta2,
            theta3,
            theta4,
            theta5,
            theta6]

def to_deg(theta):
    return theta * 180 / pi
