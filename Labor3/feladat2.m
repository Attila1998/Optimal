clear all;
close all;
clc;

x0 = [2, 3, 1];
LB = []; UB = [];
A = []; B = [];
Aeq = [1, 1, 1; 1, -1, -1]; Beq = [3; 8];
o = optimset();
o = optimset(o, 'TolX', 1e-8, 'MaxIter', 100);
[xmin, fval] = fmincon(@fg, x0, A, B, Aeq, Beq, LB, UB, @nlin, o);
disp('Minimum pont: ');
disp(xmin);
disp('A fuggveny erteke a minimum pontban: ');
disp(fval);

function f = fg(x)
    f = x(1) * x(2) * x(3);
end

function [ce, ceq] = nlin(x)
    ceq = [x(1) + x(2) + x(3) - 3; x(1) - x(2) - x(3) - 8];
    ce = [];
end