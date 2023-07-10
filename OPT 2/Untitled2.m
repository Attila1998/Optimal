%% Laborvizsga
clear all;
close all;
clc;

%% Rendszermátrixok
A=18;
B=-11;
C=8;
D=0;

%%  Diszkretizálás és mintavétel
Ts=0.1;
sys = ss(A,B,C,D);     %% rendszer létrehozás a mátrixokból
disc = c2d(sys,Ts);    %% a folytonos rendszer átalakítása diszkrétté

[Ad,Bd,Cd,Dd] = ssdata(disc);  %% A rendszer mintavételezése, innen már a diszkrét mátrixokkal dolgozunk tovább

%% ARE modszer
R=0.1*eye(1) % mert 1 bemenet van
Q=10*eye(1)  % mert 1 allapot van

%% Rikatti egyenlet kiszamolas
 P=are(Ad,Bd*R^-1*Bd',Q);
%% Nyilt hurok szimulacio
x0=[8];                        % kezdeti állapot
t=0:0.1:20;                    % idõ



szorzo=10;
u=[szorzo*ones(length(t),1)]   % bemenõ jel

[y,t,x]=lsim(ss(Ad,Bd,Cd,Dd), u,t,x0); % kimenet kiszámolása

%% Nyílt rendszer ábrázolása
figure;
plot(t,y, t, u);
legend('nyilt hurok kimenet', 'bemenet')

%% Erõsítés kiszámolás
K=inv(R)*Bd'*P;

%% Zart, szabalyzott hurok

A_zart=Ad-B*K;           %% itt kiszámoljuk a zárt rendszert, felhasználva az erõsítést
B_zart=zeros(size(Bd));  %% mert kiszámoltuk, itt a bemenõ jel mátrixa nullmátrix

[y,t,x]=(lsim(ss(A_zart,B_zart,Cd,Dd),u,t,x0));  %% uj rendszer válaszának kiszámolása

%% Zárt rendszer kirajzolása
figure;
plot(t,y ,t,-K*x');
legend('Zart hurok', 'Vezerlo jel')

