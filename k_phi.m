function [ phi, k ] = k_phi( R )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    phi = acos((trace(R) - 1) / 2);
    K = (R - R') / (2 * sin(phi));
    k = [-K(2, 3); K(1, 3); -K(1, 2)];

end

