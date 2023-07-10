clear all;
close all;
clc;

M = 50;
nu = 2;
global A B Q R
A = [0 1 0 0;
    0 -nu/M 0 0;
    0 0 0 1 ;
    0 0 0 -nu/M];

B = [0 0;
    1/M 0;
    0 0;
    0 1/M];

C = [1 0 0 0;
    0 0 1 0];

D = [0 0;
    0 0];

R = 0.1*eye(2);
Q = 1000*eye(4);
F = zeros(size(Q));

P = are(A,B*inv(R)*B',Q)

%% Potter but not Harry

Ppotter = pottersajat(A,B,Q,R)
%% Schur

Pshure = SchurSajat(A,B,Q,R)

%% Ode45

Pv=ode45(@fg,50:-0.1:0,F(:))
plot(Pv.y');
P=Pv.y(:,end);
Pode=reshape(P,4,4)