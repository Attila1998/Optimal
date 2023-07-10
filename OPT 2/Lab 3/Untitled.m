clc;
close all;
clear all;

%% Paraméter választás

M = 5; %tömeg
mu = 0.1; %surlódás

A = [0 1;   %rendszer mátrix
    0 -mu/M];
B = [0;1/M]; %bemeneti mátrix
C = [1 0];
D = [0]

x0 = [10;10];

t = 0:0.1:10;

u = 10*ones(1,length(t));%t hosszúsú tömb

[y,t,x] = lsim(ss(A,B,C,D),u,t,x0);
subplot(3,1,1)
plot(t,x(:,1)); %elmozdulás

subplot(3,1,2)
plot(t,x(:,2)); %sebesség

subplot(3,1,3)
plot(t,u);

%% Szabályzó terv
R = 5000;
Q = eye(2)*100;%f?átlo 100-as, 2x2 mátrix

%% Ricatti megoldáááás

P = are (A,B*inv(R)*B',Q);

K = inv(R)*B'*P;

%% Szabályzó szimuláció
Azart = A-B*K;
Bzart = zeros(size(B));
figure(2);
[y,t,x] = lsim(ss(Azart,Bzart,C,D),u,t,x0);
subplot(3,1,1)
plot(t,x(:,1)); %elmozdulás

subplot(3,1,2)
plot(t,x(:,2)); %sebesség

subplot(3,1,3)
plot(t,-K*x');