clc;
close all;
clear all;

x0=[2;5];
A=[0 1;0 0];
B=[0;1];
C=eye(2);
D=[0;0];

%% folytonos allapotteres modell

Ts=0.01;
sys=ss(A,B,C,D);

%% diszkretizaltunk/mintaveteleztunk
sys2=c2d(sys,Ts);

[Ad,Bd,Cd,Dd]=ssdata(sys2);
epsz=10^-3;
t=0:Ts:100;
x=x0;
utomb=0;
for i=1:length(t)-1
    u=-sign(x0(2));
    x0=Ad*x0+Bd*u;
    x=[x x0];
    utomb=[utomb u];
    if abs(x0(1))<epsz && abs(x0(2))<epsz
        break;
    end
end

n=length(x);
plot(t(1:n),x');
title("Kimeneti ertekek valtozasa")
figure(2);
plot(t(1:n),utomb);
title("Bemenet es annak figyelese")
figure(3);
plot(x(1,:),x(2,:));
title("A kimenetek valtozasa")