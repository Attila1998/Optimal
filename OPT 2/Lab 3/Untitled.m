clc;
close all;
clear all;

%% Param�ter v�laszt�s

M = 5; %t�meg
mu = 0.1; %surl�d�s

A = [0 1;   %rendszer m�trix
    0 -mu/M];
B = [0;1/M]; %bemeneti m�trix
C = [1 0];
D = [0]

x0 = [10;10];

t = 0:0.1:10;

u = 10*ones(1,length(t));%t hossz�s� t�mb

[y,t,x] = lsim(ss(A,B,C,D),u,t,x0);
subplot(3,1,1)
plot(t,x(:,1)); %elmozdul�s

subplot(3,1,2)
plot(t,x(:,2)); %sebess�g

subplot(3,1,3)
plot(t,u);

%% Szab�lyz� terv
R = 5000;
Q = eye(2)*100;%f?�tlo 100-as, 2x2 m�trix

%% Ricatti megold����s

P = are (A,B*inv(R)*B',Q);

K = inv(R)*B'*P;

%% Szab�lyz� szimul�ci�
Azart = A-B*K;
Bzart = zeros(size(B));
figure(2);
[y,t,x] = lsim(ss(Azart,Bzart,C,D),u,t,x0);
subplot(3,1,1)
plot(t,x(:,1)); %elmozdul�s

subplot(3,1,2)
plot(t,x(:,2)); %sebess�g

subplot(3,1,3)
plot(t,-K*x');