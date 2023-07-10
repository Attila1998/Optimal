% 11 laborhoz



clear all;
close all;
clc;

%Pál Attila

Ad=[0.16   -0.4002   -0.478
    0.0390    0.7032   -0.4637
    0.0028    0.0887    0.9820];
Bd=[0.0390 0.1
    0.0028 0.2
    0.0001 0.1];
Cd=[1 2 -1];
D=[0 0]

Ts=0.1;
t=0:Ts:40;
u1= -5*square(0.2*t);
u2=3*square(t*0.125);
% 3 állapot,2 bemenet, 1 kimenet
x0=[2 4 1]';
sys=ss(Ad,Bd,Cd,D,Ts)
%% meres
u=[u1' u2'];
[y,t,x]=lsim(sys,u,t,x0); %szimulálja a sys-t u-t függvényében x0 bemenetre

w= 0.5*randn(length(t),3);
v= 0.01*randn(length(t),1);
% w,v zaj

ssq=rand(length(t),1)*2-1;  % [ 0 1]
for k=1:length(t)
   if (ssq(k))>0
       ssq(k)=0;
   else
       ssq(k)=1;
    end
end
 
w=[w(:,1).*ssq w(:,2).*ssq w(:,3).*ssq];
v=v.*ssq;

xz=x+w  % N x 3
yz=Cd*xz'+v';


plot(t,y,'b.',t,yz,'r:','Linewidth',1)
legend('Idealis nem zajos kimenet','Zajos kimenet');



Q=cov(w); % 3 x 3
R=cov(v); %1 x 1


x0b=randn(3,1);
P0b=100*eye(3);
%% szimulacio es becslo algoritmus

X_tarolo=[x0b];
P_Tarolo = [trace(P0b)];
for i=1:length(t)-1
    %predikcios rész
   xtemp=Ad*x0b+Bd*u(i,:)';
   Ptemp=Ad*P0b*Ad'+Q;
   %er?sités számitás
   K=Ptemp*Cd'*inv(Cd*Ptemp*Cd'+R);
   %javitás/frissités
   P0b=(eye(3)-K*Cd)*Ptemp;
   x0b=xtemp+K*(yz(i)-Cd*xtemp);
    X_tarolo=[X_tarolo x0b];
    yb(i) = Cd*x0b;
    P_Tarolo = [P_Tarolo trace(P0b)];
end
figure(2)
subplot(3,1,1)
plot(t,x(:,1),'r',t,xz(:,1),'g.',t,X_tarolo(1,:),'k');
legend('x1 idealis','x1 zajos','x1 becsult');
grid on;

subplot(3,1,2)
plot(t,x(:,2),'r',t,xz(:,2),'g.',t,X_tarolo(2,:),'k');
legend('x2 idealis','x2 zajos','x2 becsult');
grid on;

subplot(3,1,3)
plot(t,x(:,3),'r',t,xz(:,3),'g.',t,X_tarolo(3,:),'k');
legend('x3 idealis','x3 zajos','x3 becsult');
grid on;

figure(4);
plot(t(1:10),P_Tarolo(1:10));
legend("P nyoma");

% figure(4);
% plot(t,yz,t,yb);
% legend("zajos kimenet","becsult kimenet");

 %abrazolni a x,xz,xb
  %          y,yb
   %          Ptr