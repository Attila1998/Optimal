clear all;
close all;
clc;

%% Rendszer a sík mozgásra
c=5;
m=50;
global A B Q R;

A=[ 0 1 0 0
    0 -c/m 0 0
    0 0 0 1
    0 0 0 -c/m];
B=[0 0
   1/m 0
   0 0
   0 1/m];
C=[1 0 0 0
   0 0 1 0];
D=zeros(2);

%% ARE modszer
R=0.1*eye(2) % mert 2 bemenet van
Q=eye(4)  % mert 4 allapot van

P=are(A,B*R^-1*B',Q);

%% Potter behivasa
Potter_P=Potter_Aut3(A,B,Q,R);

%% Schur
Schur_P=Schur_Aut3(A,B,Q,R);

%% Ode 45 (visszaintegralas)
F=zeros(4);
Pv=ode45(@fg_Aut3,10:-0.001:0, F(:)) %% kiintegralas
Pm=Pv.y(:,end)
Ode_P=reshape(Pm, 4,4);

%% Newton
Newton_P=NewtonAut3(A,B,Q,R)
%% Kiiratas
Potter_P
Schur_P
Ode_P
Newton_P

%% Szimulacio nyilt hurokban

szorzo1=5;
szorzo2=6;
x0=[8 ; 3 ;21;2];
t=0:0.1:20;

u=[szorzo1*ones(length(t),1), szorzo2*ones(length(t),1)]; % bemeno jel

[y,t,x]=lsim(ss(A,B,C,D), u,t,x0);

figure;
subplot(2,1,1);
plot(t,y);



subplot(2,1,2);
plot(y(:,1),y(:,2));

%% Menu
m=menu('Ricatti egyenlet megkapásának módja', 'ARE', 'Potter','Schur', 'Ode45', 'Newton modszer')

if m==1
    K=inv(R)*B'*P
end

if m==2
    K=inv(R)*B'*Potter_P
end

if m==3
    K=inv(R)*B'*Schur_P
end

if m==4
    K=inv(R)*B'*Ode_P
end

if m==5
    K=inv(R)*B'*Newton_P
end


%% Zart hurok

A_zart=A-B*K;
B_zart=zeros(size(B));

[y,t,x]=(lsim(ss(A_zart,B_zart,C,D),u,t,x0));

figure
subplot(3,1,1)
plot(t,x(:,1), t,x(:,3));
title('Elmozdulas zárt hurokban');
legend('x irányban', 'y irányban')

subplot(3,1,2)
plot(t,x(:,2), t,x(:,4));
title('Sebesseg zárt hurokban');

subplot(3,1,3)
plot(t,-K*x');
title('Vezérlõ  jel zárt hurokban');


