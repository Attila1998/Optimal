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

%% Nyílt hurok szimulációja

Fx=5; % huzó erõ x irányba
Fy=6; % huzó erõ y irányba

x0=[10 ; 7 ;8;3];
t=0:0.1:30;

u=[Fx*ones(length(t),1), Fy*ones(length(t),1)]; % bemeno jel
[y,t,x]=lsim(ss(A,B,C,D), u,t,x0);




figure
plot(t,y(:,1),t,y(:,2));
legend('X elmozdulás', 'Y elmozdulás');
title('Elmozdulások')



%% Követõ szabalyzó tervezése

R=0.5*eye(2); %% a bemenetek szama adja a dimenziót

% RQL szabalyzo matrixinak a definialasa




Q=1000*eye(2); % nyomon követett kimenetek száma



P=are(A, B*inv(R)*B', C'*Q*C); % Ricatti egyenlet megoldasa
Kfb=-inv(R)*B'*P;
Kff=-inv(R)*B'*((A-B*inv(R)*B'*P)')^(-1)*C'*Q;

%% Zárt rendszer szimulációja

Azart=A+B*Kfb;
Bzart=B*Kff;



z1=8*sin(t);        % jel az x koordináta tengelyen, amit követni akarunk
z2=5*ones(size(t)); 

 

z=[z1,z2];
[y,t,x]=lsim(ss(Azart,Bzart,C,D),z,t,x0);

figure;
subplot(3,1,1);
plot(t,z(:,1),t,y(:,1));
legend("Elõírt pálya","Kimenet");

subplot(3,1,2);
plot(t,z(:,2),t,y(:,2));
legend("Elõírt pálya","Kimenet");

u=Kff*z'+Kfb*x';
subplot(3,1,3);
plot(t,u);
title('Vezérlõ jel');
legend('u1','u2')