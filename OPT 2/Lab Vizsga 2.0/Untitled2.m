clear all;
close all;
clc;

%% Rendszer matrixok
Ad=[4 12 1; -1 9 0; 8 7 10]
Bd=[1 0 ;0.2 -1;2 3];
Cd=[-1 0 2;3 -6 7];
D=zeros(2,2);

%% Stabilitas
[Lamda]=eig(Ad)
abs(Lamda)

%% Szabalyzohatosag

szab_matrix=ctrb(Ad,Bd)
meret=rank(szab_matrix);
if meret==size(Ad,1)
    disp('Szabalyozhato')
else
    disp('Na, majd maskor (Nem szabalyozhato)')
end

megfigy_matrix=obsv(Ad,Cd);
meret2=rank(megfigy_matrix);

if meret2==size(Ad,1)
    disp('Megfigyelheto')
else
    disp('Na, majd maskor (Nem megfigyelheto)')
end

%% Szabalyzo tervvezes
R=2*eye(2);    % bemeneteket sulyoz, szimmetrikus, pozitiv definit
               % legtisztabb: valahanyszor eye
Q=500*eye(3);       % allapotokat sulyoz
                     % Q>R
                     
%Pd=dare(Ad,Bd, Q,R)      



%% Sajat modszerek
% Potter
%P_potter=Potter_Aut3_diszkret(Ad,Bd,Q,R)
% Shur
P=Schur_Aut3_diszkret(Ad,Bd,Q,R)

%% Rekurziv
% F=zeros(4);
% N=10; %% hany lepest latok elore a palyabol
% P=Rekurziv(Ad,Bd,Q,R,F,N)
% Hiba=norm(Pd-P)
% 
% kellet volna c2d
K=-inv(R+Bd'*P*Bd)*Bd'*P*Ad
% 
%% Szimulacio (nyilt hurok)
Ts=0.1;
t=0:Ts:10;
u1=5*ones(size(t));
u2=5*ones(size(t));

Diszkret_rendszer=ss(Ad,Bd,Cd,D,Ts)

u=[u1;u2]';

x0=[1; 2; 3;];
x0_mentett=x0;

[y,t,x]=lsim(Diszkret_rendszer, u,t,x0);

figure(1)
subplot(3,1,1);
stairs(t,x)  %% jel diszkret abrazolasa
title('Nyilt hurok')
%% Zart rendszer szimulacio
% 
% Adz=(Ad+Bd*K); % zart ad
% Bdz=zeros(size(Bd));
% Cdz=Cd;
% Ddz=D;
% 
% Zart_rendszer=ss(Adz,Bdz,Cdz,Ddz, Ts);
% [y,t,x]=lsim(Zart_rendszer, u,t,x0);
% 
% subplot(3,1,2);
% stairs(t,x)
% title('Zart hurok szimulacio, allapotok')
% subplot(3,1,3);
% plot(t,K*x')
% title('Vezerlojel')