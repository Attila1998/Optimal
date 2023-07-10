close all;
clear all;
clc;


%% Allapot matrixok
A=[4 2 -1; -1 19 10; -8 7 20]
B=[4 1 10; 1 0 -2; 5 0 1]
C=[11 -2 20]
D=0;

%% Nyilt hurok szimulacio
Ts=0.1;
t=0:Ts:10;
x0=[1; 7; 7];
u(1,:)=1*ones(size(t)); %egy konstans ero ami huz
u(2,:)=2*ones(size(t)); %masik konstans ero ami huz
u(3,:)=2*ones(size(t));

[y,t,x]=lsim(ss(A,B,C,D),u,t,x0); 

subplot(2,1,1);
plot(t,x)

subplot(2,1,2);
plot(t,y)

%% Kovetendo jel


z3=square(t);

z=[z3];

%% Q, R meghatarozas
R=0.1*eye(3);
Q=100*eye(1);

P=NewtonAut3(A,B,C'*Q*C,R)


%% Vezerlo jelek kiszamolasa
Kfb = -(R^-1*B'*P);%feed back
Kff=-(R^-1*B'*((A-B*R^-1*B'*P)')^-1)*C'*Q;

%% zart rendszer szimulacioja
Az=A+B*Kfb; % A zart
Bz=B*Kff; %B zart

[y,t,x]=lsim(ss(Az,Bz,C,D),z,t,x0); %megoldjuk, majd amit kirajzoljuk

figure
%plot(t,y)
plot(t, y,'*', t,z)
legend('kimenet', 'eloirt palya');


