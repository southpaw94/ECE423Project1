# coding: utf-8
from inverse_k import inverse_k
from numpy import matrix
from mpl_toolkits.mplot3d import axes3d
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import animation

def k_phi(R):
    """ Takes a 3x3 rotation matrix and returns 
    a 3x3 skew-symmetric K rotation matrix and
    a rotation angle phi"""
    phi = np.arccos((np.trace(R) - 1) / 2)
    K = (R - R.T) / (2 * np.sin(phi))
    return K, phi

# Define our start and end matrices
A1 = matrix([[1, 0, 0, -0.25], 
             [0, -1, 0, 1.5], 
             [0, 0, -1, 1.25], 
             [0, 0, 0, 1]])
A2 = matrix([[0, 0, 1, 0.5], 
             [0, -1, 0, 1.75], 
             [1, 0, 0, 0.8], 
             [0, 0, 0, 1]])

# Grab the position vectors and rotation matrices
# from the combined representation
p1, p2 = A1[:3, 3], A2[:3, 3]
R1, R2 = A1[:3, :3], A2[:3, :3]

# starting and ending three vector arrays, x, y, z, u, v, w
# for quiver function
ax1 = np.array([np.concatenate((p1, R1[:3, 0])), 
    np.concatenate((p1, R1[:3, 1])),
    np.concatenate((p1, R1[:3, 2]))])
ax2 = np.array([np.concatenate((p2, R2[:3, 0])),
    np.concatenate((p2, R2[:3, 1])),
    np.concatenate((p2, R2[:3, 2]))])

# Rotation and position relative to starting position
R21 = R1.T * R2
p21 = p2 - p1

# Calculate K rotation vector and phi rotation angle
K, phi = k_phi(R21)

# Create new figure, new 3d axes, and 3x3 Identity matrix
figure = plt.figure()
ax = figure.add_subplot(111, projection='3d')
I = np.identity(3)

# For each of 10 incremental positions
for i in range(10):
    # ith position
    p_i = p21 / 10 * i + p1
    # ith rotation
    phi_i = phi / 10 * i
    # ith rotation matrix
    R_i = I + K * np.sin(phi_i) + K**2 * (1 - np.cos(phi_i))
    # ith rotation wrt base
    R_i = R1 * R_i
    
    # Create the set of vectors denoting this frame
    axis = np.array([np.concatenate((p_i, R_i[:3, 0])),
                     np.concatenate((p_i, R_i[:3, 1])),
                     np.concatenate((p_i, R_i[:3, 2]))])
    colors = ['r', 'g', 'b']

    # Draw the vectors indicating each of the three axes
    for j in range(3):
        x, y, z, u, v, w = axis[j]
        ax.quiver(x, y, z, u, v, w, length=1, color=colors[j], arrow_length_ratio=0.1, pivot='tail')

# Draw the final frame
for i in range(3):
    x, y, z, u, v, w = ax2[i]
    ax.quiver(x, y, z, u, v, w, length=1, color=colors[i], arrow_length_ratio=0.1, pivot='tail')

# Some final formatting of 3D plot
ax.set_xlim([-0.5, 1.5])
ax.set_ylim([-0.0, 2.0])
ax.set_zlim([-0.0, 2.0])
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
ax.view_init(elev=7, azim=75)
plt.show()
