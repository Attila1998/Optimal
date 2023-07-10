clear all;
close all;
clc;


omega = 2.5;
tau = 0.25;
S = 1;
 
A = [0 1 0; 0 0 -omega^2;0 1 -1/tau];
B = [0 S*omega^2 0]';
C = [1 0 0];
D = 0;

Ts = 0.1;

%Diszkretizálás
[Ad,Bd,Cd,Dd] = c2dm(A,B,C,D,Ts);

t=0:Ts:40;
u=-5*square(0.2*t);


x0=[2 4 1]';

x0i = x0;

w= 0.5*randn(length(t),3);
v= 0.001*randn(length(t),1);

Qf=cov(w);  %3 x 3
Rf=cov(v);  %1 x 1

x0b=randn(3,1);
P0b=100*eye(3);
Fi = Ad;
Ga = Bd;
R = 20;
Q = 10;
yref = 15*square(0.5*t);
txb=x0b;
txi=x0i;
for i=1:length(t)-1
    %meres
    yz(i+1) = Cd*x0+v(i)*0;
    x0=Ad*x0+Bd*u(i)+w(i,:)';
    
    yzi(i+1) = Cd*x0i+v(i)*0;
    x0i=Ad*x0i+Bd*u(i);
    
   xtemp=Ad*x0b+Bd*u(i)';
   Ptemp=Ad*P0b*Ad'+Qf;
   K=Ptemp*Cd'*inv(Cd*Ptemp*Cd'+Rf);
   P=(eye(3)-K*Cd)*Ptemp;
   xi=xtemp+K*(yz(i)-Cd*xtemp);
   x0b=xi;
   yb(i+1)=Cd*xi;
   P0b=P;
   
   %szabalyzas
   P = dare(Fi,Ga,Cd'*Q*Cd,R);
   K1 = -(R+Ga'*P*Ga)^-1*Ga'*P*Fi; 
   K2 = (R+Ga'*P*Ga)^-1*Ga'*((eye(3)-Fi-Ga*K1)')^-1*Cd'*Q;
   u(i+1) = K1*x0+K2*yref(:,i);
    txb=[txb x0b];
    txi=[txi x0i];
%    tP=[tP trace(P)];

end

plot(t,yz,'r',t,yb,'b');
legend("zajos kimenet","becsult kimenet");


% grafikus
% figure
% subplot(311)
% plot(t,x(:,1),'k',t,xz(:,1),'.r',t,txb(1,:),'b');
% legend("idealis nem zajos x1","zajos x1","becsult x1");
% subplot(312)
% plot(t,x(:,2),'k',t,xz(:,2),'.r',t,txb(2,:),'b');
% legend("idealis nem zajos x2","zajos x2","becsult x2");
% subplot(313)
% plot(t,x(:,3),'k',t,xz(:,3),'.r',t,txb(3,:),'b');
% legend("idealis nem zajos x3","zajos x3","becsult x3");