close all;
clear all;
clc;

f = @ (x) x(1)^2+x(2)^3+x(1)*x(2)+2*x(1)

xk = [3;3] %oszlopvektor
h = 0.001; %pontoság
S = 0.001 % lépéshossz
MaxIter = 1000;
%gr = %fugveny

x = -10:0.01:10;
y = x;

    [xr,yr] = meshgrid(x,y);
    mesh(xr,yr,xr^2+yr^2+xr*yr+2*xr);
    hold on;
    x0 = ginput(1)';
    plot(x0(1),x0(2),'.r');
    
 for i=1:MaxIter
   %    if(norm(x))
   M = lab5Grad(f,x0,h);%fugvenynev
   xkn = x0+S*M;
   %if(norm(gr)<1e-10) || (abs(norm(x01-x0))<=10e-10) && (abs(f(x01)-f()))
    %
   %end
   x0 = xkn
   plot(x0(1),x0(2),'.r')
 end