close all;
clear all;
clc;
% celunk, hogy x0 ban egy adott sebesseggel x2 es elmozdulassal x1 megy 
%egy test amit nu surlodassal lassul es mi kell szabalyozzuk, optimalisan,
%hogy az adott ero fugggvenyeben egy adott sebesseggel es elmozdulassal 
%menjen tovabb


% are fuggvent hasznalata,algebrai Riccatti egyenloseg
M=10; %tomeg
nu=0.8; %surlodas

A=[0 1; 0 -nu/M];
B=[0 ; 1/M];
C=[ 1 0];
D=0;

x0=[-2;20];

t=0:0.1:50;

u=8*ones(size(t)); %8 az ero amivel huzom

[y,t,x]=lsim(ss(A,B,C,D),u,t,x0);

subplot(3,1,1)
plot(t,x(:,1)); %elmozdulas
title("Elmozdulas");

subplot(3,1,2)
plot(t,x(:,2)); %sebesseg
title("Sebesseg");

subplot(3,1,3)
plot(t,u);      % konstans ero amivel huzom, tehat a bemenet
title("konstans ero amivel huzom, tehat a bemenet");

%% szabalyzo tervezes
R=0.1; %bemenetek sulyzoi
Q=eye(2)*3; %allapotok sulyzoi

P=are(A,B*R^-1*B',Q); %kiszamitja a ricatti matrixot
K=R^-1*B'*P; %szabalyzo erositese

A_visszacsatolt=A-B*K; % zart rendszer allapotmatrix
B_visszacsatolt=zeros(size(B));

%szabalyzott zart rendszer:

[y,t,x]=lsim(ss(A_visszacsatolt,B_visszacsatolt,C,D),u,t,x0);

figure();

subplot(3,1,1)
plot(t,x(:,1)); %elmozdulas
title("Szabalyzo Elmozdulas");

subplot(3,1,2)
plot(t,x(:,2)); %sebesseg
title("Szabalyzo Sebesseg");

%u=-K*x, mert visszacsatoltuk az erositessel

subplot(3,1,3)
plot(t,-K*x');      % konstans ero amivel huzom, tehat a bemenet
title("Szabalyzo konstans ero amivel huzom, tehat a bemenet");
%lathato, hogy behozza 0 ba, tehat tartani fogja a sebesseget, ugy, hogy
%huz egy nagyot rajta, majd lassan lelassul es beall, nagy erovel allok
%neki s majd kezdem lassabban






