clc;
clear all;
close all;

M1 = 50;
M2 = 10;
k = 2; %rug� ��lland�

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

%% nyilt hurok szimul�ci�

[y,t,x] = lsim(sys,u,t,x0);
plot(t,x);

%% szab�lyz� tervez�s
%�llapot ut�ni szab�lyz�

R = 50;
Q = 400*eye(4);

P = pottersajat(A,B,Q,R)

K = inv(R)*B'*P %szab�lyz� jel

Azart = A-B*K

Bzart = zeros(size(B));

syszart = ss (Azart,Bzart,C,D);

[y,t,x] = lsim(syszart,u,t,x0);
figure;
plot(t,x);

figure
plot(t,-K*x');%szab�lyz� jel

%% koveto szab�lyz�

R = 1;
Q = 400;

P = pottersajat(A,B,C'*Q*C,R)

Kfb = -inv(R)*B'*P %szab�lyz� jel

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
plot(t,Kfb*x'+Kff*z');%szab�lyz� jel
rugos_rendszer_new;
