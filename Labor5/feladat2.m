clear all;
close all;
clc;

f = @(x) x(1)*exp(-x(1)^2-x(2)^2);
xk = [-2; 2];
allCords = [xk(1), xk(2), f(xk)];

MaxIter = 100;
xTol = 1e-3;
funTol = 1e-3;

h = 0.001;
S = 0.01;

x = -10 : 0.01 : 10;
y = -10 : 0.01 : 10;
[xr, yr] = meshgrid(x, y);

figure(1);
contour(xr, yr, xr.*exp(-xr.^2-yr.^2));

for i = 1 : MaxIter
    xk_last = xk;
    gr = aut3grad(f, xk, h);
    H = aut3hess(f, xk, h);
    S = (gr' * gr) / (gr' * H * gr);
    M = -gr;
    xk = xk + S * M;
    
    hold on;
    plot(xk(1), xk(2), 'r*');
    allCords = [allCords; xk(1), xk(2), f(xk)];
    
    if abs(xk - xk_last) < xTol
        break;
    end
end


figure(2);
plot3(allCords(:, 1), allCords(:, 2), allCords(:, 3), '*r');
hold on;
mesh(xr, yr, xr.*exp(-xr.^2-yr.^2));

disp("Minium pont: ")
disp(xk);
