# coding: utf-8
from inverse_k import inverse_k
from numpy import matrix
from mpl_toolkits.mplot3d import axes3d
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import animation

def k_phi(R):
    phi = np.arccos((np.trace(R) - 1) / 2)
    K = (R - R.T) / (2 * np.sin(phi))
    return K, phi

A1 = matrix([[1, 0, 0, -0.25], 
             [0, -1, 0, 1.5], 
             [0, 0, -1, 1.25], 
             [0, 0, 0, 1]])
A2 = matrix([[0, 0, 1, 0.5], 
             [0, -1, 0, 1.75], 
             [1, 0, 0, 0.8], 
             [0, 0, 0, 1]])

p1, p2 = A1[:3, 3], A2[:3, 3]
R1, R2 = A1[:3, :3], A2[:3, :3]

ax1 = np.array([np.concatenate((p1, R1[:3, 0])), 
    np.concatenate((p1, R1[:3, 1])),
    np.concatenate((p1, R1[:3, 2]))])
ax2 = np.array([np.concatenate((p2, R2[:3, 0])),
    np.concatenate((p2, R2[:3, 1])),
    np.concatenate((p2, R2[:3, 2]))])
#axes = [ax1, ax2]
#ax1 = zip(*ax1)
#ax2 = zip(*ax2)

R21 = R1.T * R2
p21 = p2 - p1

K, phi = k_phi(R21)

figure = plt.figure()
ax = figure.add_subplot(111, projection='3d')
I = np.identity(3)

for i in range(10):
    p_i = p21 / 10 * i + p1
    phi_i = phi / 10 * i
    R_i = I + K * np.sin(phi_i) + K**2 * (1 - np.cos(phi_i))
    R_i = R1 * R_i
    
    axis = np.array([np.concatenate((p_i, R_i[:3, 0])),
                     np.concatenate((p_i, R_i[:3, 1])),
                     np.concatenate((p_i, R_i[:3, 2]))])
    colors = ['r', 'g', 'b']
    #x, y, z, u, v, w = zip(*axis)
    #Q = ax.quiver(x, y, z, u, v, w, length=1, color=['r', 'g', 'b'], arrow_length_ratio=0.1, pivot='tail')
    for j in range(3):
        x, y, z, u, v, w = axis[j]
        ax.quiver(x, y, z, u, v, w, length=1, color=colors[j], arrow_length_ratio=0.1, pivot='tail')

for i in range(3):
    x, y, z, u, v, w = ax2[i]
    ax.quiver(x, y, z, u, v, w, length=1, color=colors[i], arrow_length_ratio=0.1, pivot='tail')
#x, y, z, u, v, w = zip(*ax2)
#ax.quiver(x, y, z, u, v, w, length=1, color=['r', 'g', 'b'], arrow_length_ratio=0.1, pivot='tail')

ax.set_xlim([-0.5, 1.5])
ax.set_ylim([-0.0, 2.0])
ax.set_zlim([-0.0, 2.0])
ax.set_xlabel('X')
ax.set_ylabel('Y')
ax.set_zlabel('Z')
ax.view_init(elev=7, azim=75)
plt.show()
