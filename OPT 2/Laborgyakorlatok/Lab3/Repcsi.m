clear all;
close all;
clc;

%% Valtozok ertelemzes
% teta -a rep�l� tengelye �s a v�zszintes s�k k�z�tti sz�get jel�li.
% q - a sz�gsebess�g (teta sz�g v�ltoz�sa)
% 
% alfa - a rep�l� tengelye �s a sebess�g vektor k�z�tti sz�get
% delta - a rep�l� vez�rl� sz�ge (unghiul format �ntre planul orizontal �i aripa de comand� )
% t , w, S - a rendszer param�terei, melyek �lland�k (t = 0.25, w = 2.5, S = 1.6 )



%% Parameter valasztas
tao=0.25;
omega=2.5;
S=1.6;


%% Matrixok

A=[0 1 0; 0 0 omega^2; 0 1 -1/tao];
B=[0; omega^2; 0]
C=[1 0 0];
D=0;

%% Kezdeti allapot
x0=[20; 2; 7];

%% ido
Ts=0.1;
t=0:Ts:10;

u=10*ones(1,length(t));

[y,t,x]=(lsim(ss(A,B,C,D),u,t,x0));

subplot(4,1,1)
plot(t,x(:,1));
title('Teta nyilt hurokban');

subplot(4,1,2)
plot(t,x(:,2));
title('P nyilt hurokban');

subplot(4,1,3)
plot(t,x(:,3));
title('Alfa nyilt hurokban');


subplot(4,1,4)
plot(t,u);
title('Bemen� jel nyilt hurokban');
%% Szabalyzo valasztas
    R=0.1;   % a bemeneteket sulyoza, a dimenzio a bemenetek szama
    R2=1;
    R3=10;
    Q=eye(3)*100;  % �llapotokat s�lyozza
                   % pozitiv definit, es szimmetrikus
                   
%% Ricatti matrix kiszamolasa
P=are(A, B*inv(R)*B',Q)
P2=are(A, B*inv(R2)*B',Q)
P3=are(A, B*inv(R3)*B',Q)

K=inv(R)*B'*P
K2=inv(R2)*B'*P2
K3=inv(R3)*B'*P3

%% Zart hurok
figure
A_zart=A-B*K;
A_zart2=A-B*K2;
A_zart3=A-B*K3;

B_zart=zeros(size(B));

[y,t,x]=(lsim(ss(A_zart,B_zart,C,D),u,t,x0));
[y,t,x2]=(lsim(ss(A_zart2,B_zart,C,D),u,t,x0));
[y,t,x3]=(lsim(ss(A_zart3,B_zart,C,D),u,t,x0));

subplot(3,1,1);
plot(t,x(:,1));
hold on;


plot(t,x(:,2));
hold on;


plot(t,x(:,3));
legend('Teta z�rt hurokban','P z�rt hurokban','Alfa z�rt hurokban');
hold on;

title('R=0.1');
hold on;

%% R=1

subplot(3,1,2);
plot(t,x2(:,1));
hold on;


plot(t,x2(:,2));
hold on;


plot(t,x2(:,3));
legend('Teta z�rt hurokban','P z�rt hurokban','Alfa z�rt hurokban');
hold on;

title('R=1');
hold on
%% R=10
subplot(3,1,3);
plot(t,x3(:,1));
hold on;


plot(t,x3(:,2));
hold on;


plot(t,x3(:,3));
legend('Teta z�rt hurokban','P z�rt hurokban','Alfa z�rt hurokban');
hold on;

title('R=10');





figure
plot(t,-K*x'); %% visszacsatolt bemeno jel
hold on
plot(t,-K2*x');
hold on
plot(t,-K3*x');
title('Vez�rl� jel z�rt hurokban');


% altalaban R-nek minel kissebbet adunk
% Q nak minel nagyobbat
