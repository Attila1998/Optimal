clear all; close all; clc;
%kojugalt modszer --
f = @(x) 5*x(1)^2 + 6*x(2)^2 + 3*x(1)*x(2) + 7
[X Y] = meshgrid(-10:0.1:10);
Z = 5*X.^2 + 6*Y.^2 + 3*X.*Y + 7;
figure(1);
mesh(X,Y,Z);
hold on;
figure(2);
contour(X,Y,Z);
hold on;
[x0] = ginput(1)';
plot(x0(1),x0(2), 'go');
Nmax = 300;
h = 10^(-3);
epszilon1 = 10^(-8);
fmin = f(x0);
t  = [x0(1);x0(2);fmin];
osszeg = 0;
for i=0:Nmax
    gradf = gradiens(f, x0, h);
    hessmatrix = hessf(f, x0, h)';
    S = (gradf'*gradf)/(gradf'*hessmatrix*gradf);
   
    if i == 0
        M = -gradf;
        
    else
        alpha = (gradf'*gradf)/(regigradf'*regigradf)
        osszeg = osszeg + alpha * M;
        M = -gradf + osszeg;
    end
    if i > 1
        break;
    end
    
    
    x1 = x0+S*M;
    if (norm(x1 - x0)<= epszilon1 && abs(f(x1) - f(x0)) <= epszilon1) || norm(gradf) <= epszilon1
        break;% a harom megállási feltetel
    else
        x0 = x1;
        t  = [t [x0(1);x0(2);fmin]];
        plot(x0(1),x0(2), 'go');
    end
    regigradf = gradf;
end
plot(t(1,:),t(2,:),'r');