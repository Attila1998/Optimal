clear all;
close all;
clc;



A = [4 12 1;
    -1 9 0;
    8 7 10];
B = [4 1 0;
    1 0 -5;
    3 0 1];
C = [1 -2 1;
    3 -6 7];
D = 0;

R = 0.1*eye(3); % mert 3 bemenet van
Q = 10*eye(3); % mert 3 allapot van

Pare = are(A,B*R^-1*B',Q)

P = SchurSajat(A,B,Q,R)