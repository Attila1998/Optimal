clear all

%% Allapotok
Ad=[0.16   -0.4002   -0.478
    0.0390    0.7032   -0.4637
    0.0028    0.0887    0.9820];

Bd=[0.0390 0.1
    0.0028 0.2
    0.0001 0.1];  % 2 oszlop => 2 bemenet

Cd=[1 2 -1];   % <= egy sor => egy kimenet
D=[0 0]

%% ido es bemenetek
Ts=0.1
t=0:Ts:40;
u1= -5*square(0.2*t)  %bemeno jel1
u2=3*square(t*0.125); %bemeno jel2

x0=[2 4 1]';
sys=ss(Ad,Bd,Cd,D,Ts) % diszkret rendszer letrehozasa (diszkret, mert ott a Ts mintavetelezi periodus)

% meres
u=[u1' u2'];
[y,t,x]=lsim(sys,u,t,x0); % kimenet, ido, es allapotok  kiszamolasa
w= 0.8*randn(length(t),3); % 3 allapot, 3 zaj
v= 0.01*randn(length(t),1);   % 1 kimenet, a zaj dimenzioja is egy


ssq=rand(length(t),1)*2-1;  % [ 0 1] olyan jel, ami hol 0, hol 1
% a zajt nullazza, vagy atengedi
for k=1:length(t)
   if (ssq(k))>0
       ssq(k)=0;
   else
       ssq(k)=1;
    end
end
 
w=[w(:,1).*ssq w(:,2).*ssq w(:,3).*ssq]
v=v.*ssq;

xz=x+w  % N x 3   <= zajos allapotok
yz=Cd*xz'+v';    %  <= zajos kimenet (ez merheto igazan) 


plot(t,y,'b.',t, yz,'r:','Linewidth',1); % abrazolas
legend('Idealis, nem zajos kimenet', 'Zajos kimenet');



Q=cov(w) % 3 x 3
R=cov(v) % 1 x 1


 x0becsult=randn(3,1);  % kezdeti becsult allapot
 P0b=100*eye(3);  % ha randommal indultunk, a P (vagyis a szoras matrix) nagy
                  % ha jo P-bol indulunk, eleg kicsi is
 
 
%% Szimulacio es becslo algoritmus

Allapot_tarolo=[x0becsult]
Kimenet_tarolo=[Cd*x0becsult];
P_tarolo=[trace(P0b)]
for i=2:length(t)     % length(t)-1 <= mert egy allapot mar benne
   % predikcio (megjoslals)
   xtemp=Ad*x0becsult+Bd*u(i,:)'; %megjosolom elore az allapotot
   Ptemp=Ad*P0b+Ad'+Q;            % megjosolom a szorast
   %erosites szamitas
   K=Ptemp*Cd'*inv(Cd*Ptemp*Cd'+R);
   %javitas/frissites
   P0b=(eye(3)-K*Cd)*Ptemp;
   x0becsult=xtemp+K*(yz(i)-Cd*xtemp)
   Allapot_tarolo=[Allapot_tarolo x0becsult];
   ybecsult=Cd*x0becsult;
   Kimenet_tarolo=[Kimenet_tarolo ybecsult]
   P_tarolo=[P_tarolo trace(P0b)]
   
end
figure(2)
subplot(3,1,1)
plot(t,x(:,1), 'c', t,xz(:,1), 'g.', t, Allapot_tarolo(1,:), 'k')
legend('x1 idealis', 'x1 zajos', 'x1 becsult');
grid on;


subplot(3,1,2)
plot(t,x(:,2), 'c', t,xz(:,2), 'g.', t, Allapot_tarolo(2,:), 'k')
legend('x2 idealis', 'x2 zajos', 'x2 becsult');
grid on;

subplot(3,1,3)
plot(t,x(:,3), 'c', t,xz(:,3), 'g.', t, Allapot_tarolo(3,:), 'k')
legend('x3 idealis', 'x3 zajos', 'x3 becsult');
grid on;


figure(3)
plot(t,yz,'g.',t,Kimenet_tarolo,'r');

figure(4)
plot(t, P_tarolo(:));
% 
% abrazolni a x,xz,xb
%             y,yb
%             Ptr
