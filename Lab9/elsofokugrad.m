close all; clear all; clc;
% interpolacios modszer
fg = @(x) 8*x(1).^2 + 9*x(2).^2 + 5*x(1)*x(2) - 3*x(2) + 8;
x1 = -15:0.1:15;
x2 = -15:0.1:15;

[X Y] = meshgrid(x1,x2);

Z = 8*X.^2 + 9*Y.^2 + 5*X.*Y - 3*X + 8;
mesh(X, Y, Z);
hold on;
figure(2);
contour(X,Y,Z);
hold on;
x = ginput(1)';
plot(x(1), x(2),'*b');

nMax = 300;
S = 0.01;
h = 10^(-3);
epsz = 10^(-8);
fmin = fg(x);
t = [x(1); x(2);fmin]
s0 = 10^(-3); 
for i=1:nMax
    gradf = [16*x(1) + 5*x(2); 18*x(2) + 5*x(1)-3];
    gradf2 = gradiens(fg, x, h);
    hessM = hessf(fg, x, h);
    %S = ((gradf' * gradf) / (gradf' * hessM * gradf));
    %S = golden(fg, x,  gradf2, s0);
    S = interpolaciosm(fg, x,  gradf2, s0, h);% optimalis lepeshossz meghatarozasa interpolacioval
    M = -gradf2;
    x1 = x + S*M;
    x = x1;
    t = [t [x(1); x(2); fmin]];
    plot(x(1), x(2),'*r');
    
    if (norm(gradf2) <= epsz)
        break;
    end
    
    if((norm(x - x1) <= epsz) && (abs(fg(x) - fg(x1)) < 0))
        break;
    end
    
    plot(x(1), x(2),'*g');
end
plot(t(1,:), t(2, :),'k' );