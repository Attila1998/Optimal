clc;
close all;
clear all;

mu=2;
M=50;     % parameterek





% bemenet Fx, Fy

% kimenet Dx, Dy

% allapotok Dx, Vx, Dy, Vy 

global A B Q R

A=[0 1 0 0;0 -mu/M 0 0;0 0 0 1;0 0 0 -mu/M];

B=[0 0;1/M 0;0 0; 0 1/M];     % bemeneti matrix

C=[1 0 0 0;0 0 1 0;];

D=[];

%% Ny�lt hurok szimul�ci�ja

Fx=5; % huz� er� x ir�nyba
Fy=6; % huz� er� y ir�nyba

x0=[10 ; 7 ;8;3];
t=0:0.1:30;

u=[Fx*ones(length(t),1), Fy*ones(length(t),1)]; % bemeno jel
[y,t,x]=lsim(ss(A,B,C,D), u,t,x0);




figure
plot(t,y(:,1),t,y(:,2));
legend('X elmozdul�s', 'Y elmozdul�s');
title('Elmozdul�sok')



%% K�vet� szabalyz� tervez�se

R=0.5*eye(2); %% a bemenetek szama adja a dimenzi�t

% RQL szabalyzo matrixinak a definialasa




Q=1000*eye(2); % nyomon k�vetett kimenetek sz�ma



P=are(A, B*inv(R)*B', C'*Q*C); % Ricatti egyenlet megoldasa
Kfb=-inv(R)*B'*P;
Kff=-inv(R)*B'*((A-B*inv(R)*B'*P)')^(-1)*C'*Q;

%% Z�rt rendszer szimul�ci�ja

Azart=A+B*Kfb;
Bzart=B*Kff;



z1=8*sin(t);        % jel az x koordin�ta tengelyen, amit k�vetni akarunk
z2=5*ones(size(t)); 

 

z=[z1,z2];
[y,t,x]=lsim(ss(Azart,Bzart,C,D),z,t,x0);

figure;
subplot(3,1,1);
plot(t,z(:,1),t,y(:,1));
legend("El��rt p�lya","Kimenet");

subplot(3,1,2);
plot(t,z(:,2),t,y(:,2));
legend("El��rt p�lya","Kimenet");

u=Kff*z'+Kfb*x';
subplot(3,1,3);
plot(t,u);
title('Vez�rl� jel');
legend('u1','u2')