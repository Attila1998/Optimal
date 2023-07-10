clc;
clear all;
close all;

M1 = 50;
M2 = 10;
k = 2; %rugó áállandó

A = [0 1 0 0
    -k/M1 0 k/M1 0
    0 0 0 1
    k/M2 0 -k/M2 0];

B = [0
    1
    0
    0];

C = [1 0 0 0]
D = [0];

sys = ss(A,B,C,D);

%% nyilt hurok

t = 0:0.01:50;
x0 = randn(4,1);
u = 4*ones(length(t),1);

%% nyilt hurok szimuláció

[y,t,x] = lsim(sys,u,t,x0);
plot(t,x);

%% szabályzó tervezés
%állapot utáni szabályzó

R = 50;
Q = 400*eye(4);

P = pottersajat(A,B,Q,R)

K = inv(R)*B'*P %szabályzó jel

Azart = A-B*K

Bzart = zeros(size(B));

syszart = ss (Azart,Bzart,C,D);

[y,t,x] = lsim(syszart,u,t,x0);
figure;
plot(t,x);

figure
plot(t,-K*x');%szabályzó jel

%% koveto szabályzó

R = 1;
Q = 400;

P = pottersajat(A,B,C'*Q*C,R)

Kfb = -inv(R)*B'*P %szabályzó jel

Kff =-inv(R)*B'*((A-B*inv(R)*B'*P)')^(-1)*C'*Q;

Azart = A+B*Kfb

Bzart = B*Kff;

syszart = ss (Azart,Bzart,C,D);
z = square(t*0.5);
[y,t,x] = lsim(syszart,z,t,x0);
figure;
plot(t,x);

figure
plot(t,z,t,y);

figure
plot(t,Kfb*x'+Kff*z');%szabályzó jel
rugos_rendszer_new;
