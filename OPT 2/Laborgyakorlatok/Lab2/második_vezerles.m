clc;
close all;
clear all;



x0=[2;3]
A=[0 1; 0 0];
B=[0; 1];
C=eye(2);
D=[0;0];

Ts=0.01;
sys=ss(A, B, C, D);
sysd=c2d(sys, Ts);

[Ad, Bd, Cd, Dd]=ssdata(sysd) % mintavetelezi a jelet

t=0:Ts:100;
X=[x0]
U=[];
epszilon=0.1;
for i=1:length(t)-1
    
    
    vegso=x0(1)+1/2*x0(2)*abs(x0(2));
    if vegso>0
        u=-1;
    end
    if vegso<0
        u=1;
    end
    
    if vegso==0
        u=-sign(x0(2));
    end
    x0=Ad*x0+Bd*u;
    X=[X x0];
    U=[U u];
    
    if abs(x0(1))<epszilon && abs(x0(2))<epszilon
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

