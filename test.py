# coding: utf-8
from inverse_k import inverse_k
from numpy import matrix
H60 = matrix([[1, 0, 0, -0.25], [0, -1, 0, 1.5], [0, 0, -1, 1.25], [0, 0, 0, 1]])
theta = inverse_k(H60, 0.4, 0.15, 1.2, 0.1, 1.0, 0.25)
