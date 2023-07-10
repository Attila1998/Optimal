clear all;
close all;
clc;

x0 = [3, 2];
LB = []; UB = [];
A = [1 1; 1 -1; -2 -1; -0.5 1; -1 0]; B = [6; 1; -6; 4; -1];
Aeq = []; Beq = [];
o = optimset();
o = optimset(o, 'TolX', 1e-8, 'MaxIter', 100);
[xmin, fval] = fmincon(@fg, x0, A, B, Aeq, Beq, LB, UB, @nlin, o);
disp('Minimum pont: ');
disp(xmin);
disp('A fuggveny erteke a minimum pontban: ');
disp(fval);

x = -10 : 0.1 : 10;
y = -10 : 0.1 : 10;
[xr, yr] = meshgrid(x, y);
figure(1);
mesh(xr, yr, 10.*(xr - 3.5).^2 + 20.*(yr - 4).^2);
hold on;
plot3(xmin(1), xmin(2), fval, '*r');

figure(2);
contour(xr, yr, 10.*(xr - 3.5).^2 + 20.*(yr - 4).^2);
hold on;
plot3(xmin(1), xmin(2), fval, '*r');

function f = fg(x)
    f = 10*(x(1)-3.5)^2 + 20*(x(2)-4)^2;
end

function [ce, ceq] = nlin(x)
    ceq = [];
    ce = [];
end