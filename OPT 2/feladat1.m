clear all;
close all;
clc;

Th=2;
Tp=1;
Tv=0.5;

k=10;

Ts=0.2;

Ad= [0.4 0.02 0.1; -0.01 0.7 0; 0 0 0.4];
Bd=[4 1 0; 1 0 0; 0 0 1];
C=[1 -2 1];
D=[0 0 0];

Rendszer = ss(Ad,Bd,C,D);
Diszkret_rendszer=c2d(Rendszer,Ts);
[Ad, Bd, Cd, Dd]=ssdata(Diszkret_rendszer);

%% Szabalyzo tervvezes
R=5*eye(3);    % bemeneteket sulyoz, szimmetrikus, pozitiv definit
               % legtisztabb: valahanyszor eye
Q=100* eye(3);       % allapotokat sulyoz
                     % Q>R
                     
P = PotterDiszkret(Ad,Bd, Q,R);      

K=-inv(R+Bd'*P*Bd)*Bd'*P*Ad;

%% Szimulacio (nyilt hurok)

t=0:Ts:10;
u1=5*ones(size(t));
u2=5*ones(size(t));
u3=5*ones(size(t));

u=[u1;u2;u3]';

x0=[5; 3; 7];

[y,t,x]=lsim(Diszkret_rendszer, u,t,x0);

figure(1)
stairs(t,x)  %% jel diszkret abrazolasa
title('Nyilt hurok')
%% Zart rendszer szimulacio

Adz=(Ad+Bd*K); % zart ad
Bdz=zeros(size(Bd));
Cdz=Cd;
Ddz=Dd;

Zart_rendszer=ss(Adz,Bdz,Cdz,Ddz, Ts);
[y,t,x]=lsim(Zart_rendszer, u,t,x0);

figure(2)
stairs(t,x)
title('Zart hurok szimulacio, allapotok')
figure(3)
plot(t,K*x')
title('Vezerlojel')