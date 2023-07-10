clc;
clear all;
close all;

% Pál János-Attila Aut 3
M = 50;
nu = 2;

A = [0 1 0 0
    0 -nu/M 0  0
    0 0 0 1
    0 0 0 -nu/M ];

B = [0 0
    1/M 0
    0 0
    0 1/M];

C = [1 0 0 0
    0 0 1 0];
D = [0 0
    0 0];




%% rendszer modell
% folytonos---> diszkret (zoh)
Ts = 0.1;
sysd = c2d(ss(A,B,C,D),Ts,'zoh');
[Ad,Bd,Cd,Dd] = ssdata(sysd);
 x0 = [1;2;3;4];
 t = 0:Ts:100 ;
 yref=[sin(t*0.1);cos(t*0.1)];
% yref=[0*square(t);3*t];
% 
% % szabalyozo
% % N= vegtelen
R = 5 * eye (2);
Q = 50 * eye(2);
% R--> m x m (m bemenetek szama)
% Q--> p x p (p kimenetek szama)
 P=dare(Ad, Bd,Cd'*Q*Cd,R);
 K1=-inv(R+Bd'*P*Bd)*Bd'*P*Ad ;
 K2=inv(R+Bd'*P*Bd)*Bd'*inv((eye(4)-Ad-Bd*K1)')*C'*Q ;

%% % ciklus szimulaciot + szabalyozast
temp = [];
for i = 1:length(t)
   u= K1*x0+K2*yref(:,i);
   y=C*x0;
   ujxx=Ad*x0+Bd*u;
   %aktualizalok
   x0 = ujxx;
   temp = [temp [x0;u;y]];
end;

subplot(411);
plot(t,temp(1:4,:)); %szabályzot allapotok
subplot(412);
plot(t,temp(5:6,:)); %szabályzó jelek
subplot(413);
plot(t,yref(1,:),'.r',t,temp(7,:)); %szabályzás
subplot(414);
plot(t,yref(2,:),'.b',t,temp(8,:)); %Ahogy a rendszer követi az el?írt modellt
figure(2);
plot(yref(1,:),yref(2,:),'.r',temp(7,:),temp(8,:),'k')
legend('el?írt','kapott');
%% 2
% % szabalyozo
% % N= veges
 N = 10;
 F = Q;
% 
% % ciklus szimulaciot + szabalyozast
temp = [];
x0 =  [1;2;3;4];
for i=1:length(t)-N
   P=C'*F*C;    %P[k+N] a PDF bol
   g=(-2*yref(:,i+N)'*F*C)';
   for j=i+N-1:-1:i 
     P=C'*Q*C-Ad'*P*Bd*inv(R+Bd'*P*Bd)*Bd'*P*Ad+Ad'*P*Ad;
     K=-[R+Bd'*P*Bd]*Bd'*P*Ad;
     f=-0.5*inv(R+Bd'*P*Bd)*(Bd'*g);
     g=-(2*yref(:,j)'*Q*C+g'*(Ad+Bd*K))';
   end
    u=K*x0+f;
   y=C*x0;
   ujxx=Ad*x0+Bd*u;
   x0=ujxx;
   temp = [temp [x0;u;y]];
end

% grafikus
figure(3)
subplot(411);
plot(t(1:length(temp)),temp(1:4,:)); %szabályzot allapotok
subplot(412);
plot(t(1:length(temp)),temp(5:6,:)); %szabályzó jelek
subplot(413);
plot(t,yref(1,:),'.r',t(1:length(temp)),temp(7,:)); %szabályzás
subplot(414);
plot(t,yref(2,:),'.b',t(1:length(temp)),temp(8,:)); %Ahogy a rendszer követi az el?írt modellt
figure(4)
plot(yref(1,:),yref(2,:),'.r',temp(7,:),temp(8,:),'k');
legend('el?írt','kapott');