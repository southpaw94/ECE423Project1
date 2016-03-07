# coding: utf-8
from sympy.abc import theta, alpha, a, d
from sympy import symbols, Matrix
from sympy import pi
from sympy import pprint
from sympy import sin, cos, tan
from sympy import simplify

theta, d, alpha, a = symbols('theta d alpha a')
t1, t2, t3, t4, t5, t6 = symbols('theta1 theta2 theta3 theta4 theta5 theta6')

A = Matrix([[cos(theta), -sin(theta), 0, 0], 
    [sin(theta), cos(theta), 0, 0],
    [0, 0, 1, d], [0, 0, 0, 1]]) * \
    Matrix([[1, 0, 0, a], [0, cos(alpha), -sin(alpha), 0],
    [0, sin(alpha), cos(alpha), 0], [0, 0, 0, 1]])
pprint(A)

A10 = A.subs([(theta, t1), (d, 0.4), (alpha, 90 * pi / 180), (a, 0.15)])
pprint(A10)
A21 = A.subs([(theta, t2), (d, 0), (alpha, 0 * pi / 180), (a, 1.2)])
pprint(A21)
A32 = A.subs([(theta, t3), (d, 0), (alpha, 90 * pi / 180), (a, 0.1)])
pprint(A32)
A43 = A.subs([(theta, t4), (d, 1.0), (alpha, -90 * pi / 180), (a, 0)])
pprint(A43)
A54 = A.subs([(theta, t5), (d, 0), (alpha, 90 * pi / 180), (a, 0)])
pprint(A54)
A65 = A.subs([(theta, t6), (d, 0.25), (alpha, 0 * pi / 180), (a, 0)])
pprint(A65)

A60 = simplify(A10 * A21 * A32 * A43 * A54 * A65)
