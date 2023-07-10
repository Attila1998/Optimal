clear all;
close all;
clc;

x0 = [3; 2];
o = optimset();
o = optimset(o, 'TolX', 1e-8);
o = optimset(o, 'MaxIter', 100);
[xmin, fval] = fminsearch(@fun, x0, o);
disp('Minimum pont: ');
disp(xmin);
disp('A fuggveny erteke a minimum pontban: ');
disp(fval);
zfun