close all;
clear all;
clc;

% sikbeli mozgas
c = 5;  % surlodasi egyutthato
m = 50;  % tomeg

% 4 allapot
% - elmozdulas az x iranyaba
% - sebesseg az x iranyaba
% - elmozdulas az y iranyaba
% - sebesseg az y iranyaba

% ket bemenet
% - fx huzoero (x iranyaba)
% - fy huzoero (y iranyaba)

% kimenet
% - elmozdulas x iranyaba
% - elmozdulas y iranyaba

A=[ 0 1 0 0
    0 -c/m 0 0
    0 0 0 1
    0 0 0 -c/m];
B=[0 0
   1/m 0
   0 0
   0 1/m];
C=[1 0 0 0
   0 0 1 0];
D=zeros(2);

% szimulacio nyilt hurokba szabalyzo nelkul

Ts=0.1;
t=0:Ts:100;
x0=[1;1;-3;5];
u(1,:)=1*ones(size(t));
u(2,:)=20*ones(size(t));

[y,t,x]=lsim(ss(A,B,C,D),u,t,x0);

subplot(2,3,1);
plot(t,x(:,1)');
title('x1 elmozdulas x irany');
subplot(2,3,2);
plot(t,x(:,2)');
title('x2 sebesseg x irany');
subplot(2,3,3);
plot(t,x(:,3)');
title('x3 elmozdulas y irany');
subplot(2,3,4);
plot(t,x(:,4)');
title('x4 sebesseg y irany');

% subplot(2,3,5);
% plot(x(:,1),x(:,2)');
% title('x1,x2');


% koveto szabalyozo tervezes

R = 0.1*eye(2); % mert 2 bemenet van

Q = eye(2)*100; % mert 2 kimenet van

Pare = are(A,B*R^-1*B',C'*Q*C)

Kfb = -(R^-1*B'*Pare);
Kff = -(R^-1*B'*((A-B*R^-1*B'*Pare)')^-1)*C'*Q;

% zart rendszer szimulacioja
Az = A+B*Kfb;
Bz = B*Kff;

figure;

% palya
% z1 = 8*ones(size(t));
z1 = t;
z2 = 5*ones(size(t));

z = [z1 z2];

[y,t,x]=lsim(ss(Az,Bz,C,D),z,t,x0);

subplot(2,2,1);
plot(t,x(:,1)',t,z1,'r');
title('x1 elmozdulas x irany');
subplot(2,2,2);
plot(t,x(:,2)');
title('x2 sebesseg x irany');
subplot(2,2,3);
plot(t,x(:,3)',t,z2,'g');
title('x3 elmozdulas y irany');
subplot(2,2,4);
plot(t,x(:,4)');
title('x4 sebesseg y irany');

figure;

plot(z1,z2,'*r',x(:,1),x(:,3),'b','Linewidth',2);