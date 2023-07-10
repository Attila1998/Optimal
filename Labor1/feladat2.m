clear all;
close all;
clc;

o = optimset();
o = optimset(o, 'MaxIter', 100);
o = optimset(o, 'TolX', 1e-8, 'TolFun', 1e-8);

fun = @(x, y) x*exp(-x^2 -y^2);
zhandle = fcontour(fun);

f = @(x) x(1)*exp(-x(1)^2 -x(2)^2);
x0 = [1; 1];
x = fminsearch(f, x0, o);

f1 = @(x) x(1)^2 + x(2)^2 - x(1) - 8*x(2) + x(1)*x(2);
f2 = @(x) x(1) * x(2)^2 - 8*x(1) - 10*x(1);
f3 = @(x) -6*x(1)^2 -8*x(2)^2 + x(1) + 0.5*x(2) - x(1)*x(2);
f4 = @(x) x(1)*x(2)^2 - 8*x(3)*x(1)^2 - 10*x(1) + 3*x(3)*x(2) + 9*x(3)^2 + 10;

[xval1, fval1] = fminunc(f1, x0);
[xval2, fval2] = fminunc(f2, x0);
[xval3, fval3] = fminunc(f3, x0);
[xval4, fval4] = fminunc(f4, [1; 1; 1]);