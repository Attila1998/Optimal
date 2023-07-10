clear all;
close all;
clc;

%% Parameter valasztas
M=1;    % tomeg
mu=0.5  % surlodasi egyutthato


%% Matrixok

A=[0 1; 0 -mu/M];
B=[0; 1/M]
C=[1 0]
D=[0]

%% Kezdeti allapot
x0=[10; 10]

%% ido
Ts=0.1;
t=0:Ts:10;

u=10*ones(1,length(t));

[y,t,x]=(lsim(ss(A,B,C,D),u,t,x0));

subplot(3,1,1)
plot(t,x(:,1));
title('Elmozdulas nyilt hurokban');

subplot(3,1,2)
plot(t,x(:,2));
title('Sebesség nyilt hurokban');

subplot(3,1,3)
plot(t,u);
title('Vezérlõ  jel nyilt hurokban');
%% Szabalyzo valasztas
    R=10   % a bemeneteket sulyoza, a dimenzio a bemenetek szama
    Q=eye(2)*100;  % állapotokat súlyozza
                   % pozitiv definit, es szimmetrikus
                   
%% Ricatti matrix kiszamolasa
P=are(A, B*inv(R)*B',Q)

K=inv(R)*B'*P

%% Zart hurok
figure
A_zart=A-B*K;
B_zart=zeros(size(B));

[y,t,x]=(lsim(ss(A_zart,B_zart,C,D),u,t,x0));

subplot(3,1,1)
plot(t,x(:,1));
title('Elmozdulas zárt hurokban');

subplot(3,1,2)
plot(t,x(:,2));
title('Sebesség zárt hurokban');

subplot(3,1,3)
plot(t,-K*x'); %% visszacsatolt bemeno jel
title('Vezérlõ jel zárt hurokban');

% altalaban R-nek minel kissebbet adunk
% Q nak minel nagyobbat
