clc;
close all;
clear all;

mu=2;
M=50;     % parameterek


% bemenet Fx, Fy
% kimenet Dx, Dy
% allapotok Dx, Vx, Dy, Dy 
global A B Q R
A=[0     1 0     0;        % redszer matrix
   0 -mu/M 0     0;
   0     0 0     1;
   0     0 0 -mu/M]
B=[0   0;
   1/M 0;
   0   0;
   0   1/M];     % bemeneti matrix
C=[1 0 0 0;
   0 0 1 0;];
D=[];
% szimulacio nyilt hurokban
Fx=5;
Fy=6;

x0=[8 ; 4 ;10;1];
t=0:0.1:20;
u=[Fx*ones(length(t),1), Fy*ones(length(t),1)]; % bemeno jel
[y,t,x]=lsim(ss(A,B,C,D), u,t,x0);

figure;
subplot(2,1,1);
plot(t,y);

subplot(2,1,2);
plot(y(:,1),y(:,2));

%% koveto szabalyzo tervezese
R=0.1*eye(2);
% RQL szabalyzo matrixinak a definialasa
% Q=[100 0 0 0;
%     0 2 0   0;
%     0 0 100 0;
%     0 0 0 50];

Q=800*eye(2);

P=are(A, B*inv(R)*B', C'*Q*C);
Kfb=-inv(R)*B'*P;
kff=-inv(R)*B'*((A-B*inv(R)*B'*P)')^(-1)*C'*Q;
%% zart rendszer
Azart=A+B*Kfb;
Bzart=B*kff;

% z1=8*ones(size(t));
z1=8*sin(t);        % x koordinata paja
z2=5*ones(size(t));
% z2=8*cos(t);        % y
z=[z1,z2];
[y,t,x]=lsim(ss(Azart,Bzart,C,D),z,t,x0);

figure;
subplot(2,1,1);
plot(t,z,t,y);
subplot(2,1,2);
plot(z1,z2,'*r',y(:,1),y(:,2));
legend("paja","kimenet");
u=kff*z'+Kfb*x';
figure;
plot(t,u);

