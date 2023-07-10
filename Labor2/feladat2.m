clear all;
close all;
clc;

x0 = [3, 2];
LB = []; UB = [];
A = []; B = [];
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
mesh(xr, yr, -xr.*yr);
hold on;
plot3(xmin(1), xmin(2), fval, '*r');

figure(2);
contour(xr, yr, -xr.*yr);
hold on;
plot3(xmin(1), xmin(2), fval, '*r');

function f = fg(x)
    f = -x(1) * x(2);
end

function [ce, ceq] = nlin(x)
    ceq = x(2) + x(1)*exp(x(1));
    ce = [];
end