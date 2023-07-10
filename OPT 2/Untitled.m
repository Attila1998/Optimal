%% Laborvizsga
clear all;
close all;
clc;

%% Rendszermátrixok
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
x0=[8];                        % kezdeti állapot
t=0:0.1:20;                    % idõ

szorzo=10;
u=[szorzo*ones(length(t),1)]   % bemenõ jel

[y,t,x]=lsim(ss(A,B,C,D), u,t,x0); % kimenet kiszámolása

%% Nyílt rendszer ábrázolása
figure;
plot(t,y, t, u);
legend('nyilt hurok kimenet', 'bemenet')

%% Erõsítés kiszámolás
K=inv(R)*B'*Newton_P;

%% Zart, szabalyzott hurok

A_zart=A-B*K;           %% itt kiszámoljuk a zárt rendszert, felhasználva az erõsítést
B_zart=zeros(size(B));  %% mert kiszámoltuk, itt a bemenõ jel mátrixa nullmátrix

[y,t,x]=(lsim(ss(A_zart,B_zart,C,D),u,t,x0));  %% uj rendszer válaszának kiszámolása

%% Zárt rendszer kirajzolása
figure;
plot(t,y ,t,-K*x');
legend('Zart hurok', 'Vezerlo jel')

