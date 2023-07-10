close all; clear all; clc;
% lagrange multiplikatorok modszere
fg = @(x) -(50-x(1))*x(1) - (64 - x(2)) * x(2) + x(3)* (x(1) + 3/2*x(2) - 60 + x(4) - (4*x(1)) + 10);
[X Y] = meshgrid(-100:1:150);
L = -(50-X).*X - (64-Y).*Y ;
mesh(X, Y,L);
hold on;
figure(2);
contour(X,Y,L);
hold on;

% egyenloseg korlatok
x1 = -100:1:150;
x2 = (60 - x1)* 2/3;
x3 = (x1 + 10) / 4;

plot (x1, x2);
plot (x1, x3, 'r');


nMax = 300;  %max lepeshossz
lab = 19; %lambda0 -kezdeti
x = ginput(1)';
plot(x(1), x(2),'*b');
la = 19; %masodik lambda
h = 0.01;
Sx = 0.1; % adott
Slambda = 0.01; %adott
epszilon1 = 10^(-8);% kicsi szam
fmin = fg([x;la; lab]);
t  = [x(1);x(2);la;lab;fmin];
for i=1:nMax
    grad = gradiens(fg,[x;la; lab],h); % kiszamoljuk a fg gradienset
    x1 = x - Sx * grad(1:2); % meghat. a kov. pontot
    la1 = la + Slambda*grad(3); % a lambda valtozik
    
    % megallasi feltetelek , kilepunk ha teljesulnek
    if (norm(x1 - x)<= epszilon1 && abs(fg([x1;la1]) - fg([x;la1])) <= epszilon1) || norm(grad) <= epszilon1
        break;
    else % kulonben eltaroljuk 
        x = x1;
        la = la1;
        t  = [t [x(1);x(2);la; lab; fmin]];
        plot(x(1),x(2), 'go');
    end
end

%abrazoljuk
plot(t(1,:),t(2,:),'r');
figure(3);
plot(t(1, :));
hold on;
plot (t(2, :), 'r');
    