close all;
clear all;
clc;

%% konstansok
Ts=0.2;
mu=0.5;
M=20;


%% allapotok
A = [0 1 0 0 0 0;
     0 -mu/M 0 0 0 0;
     0 0 0 1 0 0;
     0 0 0 -mu/M 0 0;
     0 0 0 0 0 1;
     0 0 0 0 0 -mu/M];
B = [0 0 0;
      1/M 0 0;
      0 0 0;
      0 1/M 0
      0 0 0
      0 0 1/M];
  
C = [1 0 0 0 0 0;
     0 0 1 0 0 0;
     0 0 0 0 1 0];
D = [0 0 0;
     0 0 0;
     0 0 0];
   
%% ido es diszkretizalas   
x0=[1;2;-5;6;2;1];
t=0:Ts:100;
sys = ss(A,B,C,D);
disc = c2d(sys,Ts);

[Ad,Bd,Cd,Dd] = ssdata(disc);

m=menu('Pálya','vonal','kor');
if m==1
    yref=[t' 50*ones(size(t'))]; % x es y koordinatak
    
end;
if m==2
    yref=[sin(t') cos(t')];  % x es y koordinatak
    
end

for i=1:length(yref)
    yref(i,3)=7;
end


% figure
% plot(t,yref,'r.');
% title('referencia jel');

figure;
plot3(yref(:,1),yref(:,2), yref(:,3),'r.');
grid on;
title('Elõírt pálya')
%error('Mid script reached, this error message was made on purpose')
R=0.01*[2 1 1; 1 2 1; 1 1 2];
Q=900*eye(3);

Fi=Ad;
Ga=Bd;

m = menu('Változat','végtelen','véges');

if (m==1)
P=dare(Fi,Ga,Cd'*Q*Cd,R);
K1=-(R+Ga'*P*Ga)^-1*Ga'*P*Fi; %szabalyzo visszacsatolt erositese
K2=(R+Ga'*P*Ga)^-1*Ga'*((eye(6)-Fi-Ga*K1)')^-1*Cd'*Q; % szabalyzo elorecsatolt erositese


%ciklus szim es szab
yref=yref';
for i=1:length(t)
    u(:,i)=K1*x0+K2*yref(:,i);
    y(:,i)=Cd*x0;
    ujxx=Fi*x0+Ga*u(:,i);
    x0=ujxx;
end

% figure(1)
% hold on
% plot(t,y);


hold on
plot3(y(1,:),y(2,:), y(3,:), 'g-', 'LineWidth', 4 );
legend("referencia","szabályozott pálya");
grid on
title('A pályák ábrázolása')

figure
plot(u(1,:),'m')
hold on;
plot(u(2,:), 'c')
hold on;
plot(u(3,:), 'b')
grid on
title('Vezérlõ jelek')
legend('u1', 'u2', 'u3');



end
%error('Kezifek')

%veges 
 if (m==2)
N=25;
F=Q;
yref=yref';
for i=1:length(t)-N
    P=C'*F*C; %p=Pn
    Gt=(-2*yref(:,i+N)'*F*C); %G=gn
    G=Gt';
    for j=i+N-1:-1:i
        P=Cd'*Q*Cd-Fi'*P*Ga*inv(R+Ga'*P*Ga)*Ga'*P*Fi+Fi'*P*Fi;
        K=-(R+Ga'*P*Ga)^-1*Ga'*P*Fi;
        f=-0.5*inv((R+Ga'*P*Ga))*Ga'*G;
        G=(-2*yref(:,j)'*Q*C+Gt*(Fi+Ga*K))';
        Gt=G';     
    end 
    u(:,i)=K*x0+f;
    y(:,i)=Cd*x0;
    ujxx=Fi*x0+Ga*u(:,i);
    x0=ujxx;
 end

% figure(1)
% hold on
% plot(t(1:length(y)),y);

% figure(2)
hold on
plot3(y(1,:),y(2,:), y(3,:), 'g-', 'LineWidth', 4 );
legend("referencia","szabályozott pálya");
grid on
title('A pályák ábrázolása')

figure
plot(u(1,:),'m')
hold on;
plot(u(2,:), 'c')
hold on;
plot(u(3,:), 'b')
grid on
title('Vezérlõ jelek')
legend('u1', 'u2', 'u3');
 end