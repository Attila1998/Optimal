%% Laborvizsga
clear all;
close all;
clc;

%% Rendszerm�trixok
A=18;
B=-11;
C=8;
D=0;

%% ARE modszer
R=0.1*eye(1) % mert 1 bemenet van
Q=10*eye(1)  % mert 1 allapot van

%% Rikatti egyenlet kiszamolas
Newton_P=NewtonAut3(A,B,Q,R)

%% Nyilt hurok szimulacio
x0=[8];                        % kezdeti �llapot
t=0:0.1:20;                    % id�

szorzo=10;
u=[szorzo*ones(length(t),1)]   % bemen� jel

[y,t,x]=lsim(ss(A,B,C,D), u,t,x0); % kimenet kisz�mol�sa

%% Ny�lt rendszer �br�zol�sa
figure;
plot(t,y, t, u);
legend('nyilt hurok kimenet', 'bemenet')

%% Er�s�t�s kisz�mol�s
K=inv(R)*B'*Newton_P;

%% Zart, szabalyzott hurok

A_zart=A-B*K;           %% itt kisz�moljuk a z�rt rendszert, felhaszn�lva az er�s�t�st
B_zart=zeros(size(B));  %% mert kisz�moltuk, itt a bemen� jel m�trixa nullm�trix

[y,t,x]=(lsim(ss(A_zart,B_zart,C,D),u,t,x0));  %% uj rendszer v�lasz�nak kisz�mol�sa

%% Z�rt rendszer kirajzol�sa
figure;
plot(t,y ,t,-K*x');
legend('Zart hurok', 'Vezerlo jel')

