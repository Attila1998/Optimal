clear all;
close all;
clc;

Th=2;
Tp=1;
Tv=0.5;

k=10;

Ts=0.2;

A= [-1/Th k/Th -k/Th; 0 -1/Tp 0; 0 0 -1/Tv]

B=[0 0; 1/Tp 0; 0 1/Tv]

C=[1 0 0]
D=[0 0]

Rendszer=ss(A,B,C,D)
Diszkret_rendszer=c2d(Rendszer,Ts)
[Ad, Bd, Cd, Dd]=ssdata(Diszkret_rendszer)

%% Szabalyzo tervvezes
R=5*eye(2);    % bemeneteket sulyoz, szimmetrikus, pozitiv definit
               % legtisztabb: valahanyszor eye
Q=100* eye(3);       % allapotokat sulyoz
                     % Q>R
                     
P=dare(Ad,Bd, Q,R)      

K=-inv(R+Bd'*P*Bd)*Bd'*P*Ad

%% Szimulacio (nyilt hurok)

t=0:Ts:10;
u1=5*ones(size(t));
u2=5*ones(size(t));

u=[u1;u2]';

x0=[5; 3; 7];
x0_mentett=x0;

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

%% Megoldas for ciklussal

m=menu('Valtozat', 'Nyilt hurok', 'Zart hurok')
X=x0;
U=K*x0;
for i=1:length(t)-1
   if m==1
      uc=u(i,:)'; 
      
   else
       uc=K*x0;
       
   end
   
   x0=Ad*x0+Bd*uc;
   X=[X x0];
   U=[U uc];
    
end
X
figure
subplot(2,1,1)
plot(t,X)
title('Allapotok');

subplot(2,1,2)
plot(t,U)
title('Vezerlo jelek');



