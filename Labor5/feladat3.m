clear all;
close all;
clc;

f = @(x) 10*x(1)^2 + 5*x(2)^2 + 8*x(3)^2 + x(1)*x(2) - x(2)*x(3) + 7;
xk = [3; 2; 1];
allCords = [xk(1), xk(2), xk(3), f(xk)];

MaxIter = 1000;
xTol = 1e-3;

h = 0.001;
S = 0.01;

for i = 1 : MaxIter
    xk_last = xk;
    gr = aut3grad(f, xk, h);
    H = aut3hess(f, xk, h);
    S = (gr' * gr) / (gr' * H * gr);
    M = -gr;
    xk = xk + S * M;
    
    if abs(xk - xk_last) < xTol
        break;
    end
end


