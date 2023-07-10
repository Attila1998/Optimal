clear all;
close all;
clc;

o = optimset;
o = optimset(o, 'MaxIter', 100);
o = optimset(o, 'TolX', 1e-8, 'TolFun', 1e-8);

f = @(x) x .* sin(x).^2;
x = 2 : 0.1 : 10;
a = 5;
b = 8;
xmin = fminbnd(f, a, b, o);
plot(x, f(x));
hold on;
grid on;
plot(xmin, f(xmin), '*k');

plot(a, f(a), 'k.');
plot(b, f(b), 'k.');

x0 = 8;
xmin2 = fminsearch(f, x0, o);
plot(xmin2, f(xmin2), 'og');