clc;
clear all;
close all;

Fi=[0.16   -0.4002   -0.478
    0.0390    0.7032   -0.4637
    0.0028    0.0887    0.9820];
Ga=[0.0390 0.1
    0.0028 0.2
    0.0001 0.1];
C=[1 2 -1];
D=[0 0];

Ts=0.1;
t=0:Ts:40;
u1=-5*square(0.2*t);
u2=3*square(t*0.125);

x0=[2 4 1]';
sys=ss(Fi,Ga,C,D,Ts);
% meres
u=[u1' u2'];
[y,t,x]=lsim(sys,u,t,x0);
w= 0.5*randn(length(t),3);
v= 0.001*randn(length(t),1);


%ssq=rand(length(t),1)*2-1;  % [ 0 1]
%for k=1:length(t)
 %   if (ssq(k))>0
   %     ssq(k)=0;
   % else
     %   ssq(k)=1;
    %end
%end
 
%w=[w(:,1).*ssq w(:,2).*ssq w(:,3).*ssq]
%v=v.*ssq;

xz=x+w;  % N x 3
yz=C*xz'+v';


plot(t,y,'b.',t,yz,'r','Linewidth',1)
legend("idealis nem zajos kimenet","zajos kimenet");
x;
xz;



  
y=C*x'+v';

Qf=cov(w);  %3 x 3
Rf=cov(v);  %1 x 1
% 
% 
x0b=randn(3,1);
P0b=100*eye(3);
% % szimulacio es becslo algoritmus
% 
Ad=Fi;
Bd=Ga;
Cd=C;
Dd=D;

txb=x0b;
tP=[trace(P0b)];
yb(1)=Cd*x0b;
for i=1:length(t)-1

   xtemp=Ad*x0b+Bd*u(i,:)';
   Ptemp=Ad*P0b*Ad'+Qf;
   K=Ptemp*Cd'*inv(Cd*Ptemp*Cd'+Rf);
   P=(eye(3)-K*Cd)*Ptemp;
   xi=xtemp+K*(yz(i)-Cd*xtemp);
   x0b=xi;
   yb(i+1)=Cd*xi;
   P0b=P;
   txb=[txb x0b];
   tP=[tP trace(P)];
   

end

figure
subplot(311)
plot(t,x(:,1),'k',t,xz(:,1),'.r',t,txb(1,:),'b');
legend("idealis nem zajos x1","zajos x1","becsult x1");
subplot(312)
plot(t,x(:,2),'k',t,xz(:,2),'.r',t,txb(2,:),'b');
legend("idealis nem zajos x2","zajos x2","becsult x2");
subplot(313)
plot(t,x(:,3),'k',t,xz(:,3),'.r',t,txb(3,:),'b');
legend("idealis nem zajos x3","zajos x3","becsult x3");

figure
plot(t(1:10),tP(1:10));
legend("P nyoma");

figure
plot(t,yz,t,yb);
legend("zajos kimenet","becsult kimenet");
% 
% abrazolni a x,xz,xb
%             y,yb
%             Ptr
