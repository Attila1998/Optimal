clear all;
close all;
clc;

%% Parameter valasztas
M=50;    % tomeg
mu=2.5  % surlodasi egyutthato
Tend=20;


%% Matrixok


A=[0 1 0 0;0 -mu/M 0 0;0 0 0 1;0 0 0 -mu/M];
B = [0 0;1/M 0;0 0;0 1/M];
C = [1 0 0 0;0 0 1 0];
D = [0 0; 0 0];

%% Kezdeti allapot
x0=[100; 10; 30; 70]


%% ido
Ts=0.1;
t=0:Ts:Tend;

u=[10*ones(1,length(t));10*ones(1,length(t))] % bemen� jel l�trehoz�sa

[y,t,x]=(lsim(ss(A,B,C,D),u,t,x0));           % kimenet kisz�m�t�sa

subplot(3,1,1)
plot(t,x(:,1), t,x(:,3));
title('Elmozdulas ny�lt hurokban');
legend('x ir�nyban', 'y ir�nyban')

subplot(3,1,2)
plot(t,x(:,2), t,x(:,4));
title('Sebesseg nyilt hurokban');

subplot(3,1,3)
plot(t,u);
title('Vez�rl�  jel nyilt hurokban');
%% Szabalyzo valasztas
    R=0.5   % a bemeneteket sulyoza, a dimenzio a bemenetek szama
    Q=eye(4)*1000;  % �llapotokat s�lyozza
                   % pozitiv definit, es szimmetrikus
                   
%% Ricatti matrix kiszamolasa
P=are(A, B*inv(R)*B',Q)

K=inv(R)*B'*P

%% Zart hurok

A_zart=A-B*K;
B_zart=zeros(size(B));

[y,t,x]=(lsim(ss(A_zart,B_zart,C,D),u,t,x0));

figure
subplot(3,1,1)
plot(t,x(:,1), t,x(:,3));
title('Elmozdulas z�rt hurokban');
legend('x ir�nyban', 'y ir�nyban')

subplot(3,1,2)
plot(t,x(:,2), t,x(:,4));
title('Sebesseg z�rt hurokban');

subplot(3,1,3)
plot(t,-K*x');
title('Vez�rl�  jel z�rt hurokban');

figure
plot(x(:,1),x(:,3))
x(:,1)
x(:,3)
title('Le�rt palya');
hold on;
plot(x0(1), x0(3), 'og')
hold on;
plot(0,0,'or' );
x(size(x,1),1)
x(size(x,3),3)
size(x,1)
size(x,1)
legend('P�lya', 'Kezdet', 'C�l');
% altalaban R-nek minel kissebbet adunk
% Q nak minel nagyobbat
