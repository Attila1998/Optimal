clc;
close all;
clear all;


omega=6; 

x0=[2;3]
A=[0 omega; -omega 0];
B=[0; 1];
C=eye(2);
D=[0;0];

Ts=0.01;
sys=ss(A, B, C, D);   %% állapotteret készít a rendszermátrixokból
sysd=c2d(sys, Ts);    %% a folytonos állapotteret átviszi diszkrétbe Ts mintavételezési periódussal

[Ad, Bd, Cd, Dd]=ssdata(sysd) % mintavetelezi a jelet

t=0:Ts:100;            %% idő
X=[x0]                 %% tömb, ahova tesszük majd az állapotokat
U=[];                  %% tömb, ide tesszük majd a vezérlő jeleket
epszilon=0.1;          %% ha az állapotok változása kissebb, mint az epszilon, megállink
for i=1:length(t)-1
    u=-sign(x0(2));    % a sign az elojelet adja vissza
    x0=Ad*x0+Bd*u;     % állapotok kiszámolása
    X=[X x0];          % állapotok elmentése
    U=[U u];           % vezérlő jelek elmentése
    
    if abs(x0(1))<epszilon && abs(x0(2))<epszilon           % ha a változás kissebb az epszilonnál, kilépünk
        break
    end
end

plot(X');
title('X');
figure
plot(U);
title('Bemenet');
figure
plot(X(1,:), X(2,:));
title('Kor')

