close all;
clear all;
clc;

% fi -a rep�l� tengelye �s a v�zszintes s�k k�z�tti sz�get jel�li. x1
% q - a sz�gsebess�g (q sz�g v�ltoz�sa) x2
% alfa - a rep�l� tengelye �s a sebess�g vektor k�z�tti sz�get x3

% d - a rep�l� vez�rl� sz�ge, tehat a bemenet (unghiul format �ntre planul 
%orizontal �i aripa de comand� ) u

% tau , omega, S - a rendszer param�terei, melyek �lland�k (t = 0.25, w = 2.5, S = 1.6 )
tau = 0.25;
omega = 2.5;
S = 1.6;

A=[0 1 0; 0 0 -omega^2; 0 1 -1/tau];
B=[0 omega^2 0]';
C=[1 0 0];
D=0;

x0=[15, 4, 8];
t=0:0.01:7;

d=2*ones(size(t));
[y,t,x]=lsim(ss(A,B,C,D),d,t,x0);

subplot(4,1,1)
plot(t,x(:,1)); 
title("a rep�l� tengelye �s a v�zszintes s�k k�z�tti sz�get jel�li");

subplot(4,1,2)
plot(t,x(:,2)); 
title("a sz�gsebess�g");

subplot(4,1,3)
plot(t,x(:,3)); 
title("a rep�l� tengelye �s a sebess�g vektor k�z�tti sz�get");

subplot(4,1,4)
plot(t,d);      % konstans ero amivel huzom, tehat a bemenet
title("a rep�l� vez�rl� sz�ge");


%% szabalyzo tervezes
Q=eye(3)*2;  %allapotok sulyzoja
R=10;%bemenetek sulyzoja
P=are(A,B*R^-1*B',Q); %kiszamitja a ricatti matrixot
K1=R^-1*B'*P; %szabalyzo erositese

A_visszacsatolt=A-B*K1; % zart rendszer allapotmatrix
B_visszacsatolt=zeros(size(B));

[y,t,x1]=lsim(ss(A_visszacsatolt,B_visszacsatolt,C,D),d,t,x0);
figure();
subplot(131)
hold on;
plot(t,x1(:,1)); 
plot(t,x1(:,2)); 
plot(t,x1(:,3)); 
title("R=10");
legend("fi","q","alfa");

R=1;%bemenetek sulyzoja
P=are(A,B*R^-1*B',Q); %kiszamitja a ricatti matrixot
K2=R^-1*B'*P; %szabalyzo erositese

A_visszacsatolt=A-B*K2; % zart rendszer allapotmatrix
B_visszacsatolt=zeros(size(B));

[y,t,x2]=lsim(ss(A_visszacsatolt,B_visszacsatolt,C,D),d,t,x0);

subplot(132)
hold on;
plot(t,x2(:,1)); 
plot(t,x2(:,2)); 
plot(t,x2(:,3)); 
title("R=1");
legend("fi","q","alfa");

R=0.1;%bemenetek sulyzoja
P=are(A,B*R^-1*B',Q); %kiszamitja a ricatti matrixot
K3=R^-1*B'*P; %szabalyzo erositese

A_visszacsatolt=A-B*K3; % zart rendszer allapotmatrix
B_visszacsatolt=zeros(size(B));

[y,t,x3]=lsim(ss(A_visszacsatolt,B_visszacsatolt,C,D),d,t,x0);

subplot(133)
hold on;
plot(t,x3(:,1)); 
plot(t,x3(:,2)); 
plot(t,x3(:,3)); 
title("R=0.1");
legend("fi","q","alfa");
figure()
subplot(131)   

plot(t,-K1*x1'); 
title("R=10");

subplot(132)   

plot(t,-K2*x2');
title("R=1");

subplot(133)   

plot(t,-K3*x3');
title("R=0.1");



