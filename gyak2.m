close all;
clear all;
 clc
 o=optimset();
 o=optimset(o,'MaxIter',1000);
 m = menu('feladat','elso','masodik');
 
 if m == 1 
% % %minimum keres? parancsok:
% % %fminsearch(fg,x0,option)
% % %fminbnd(fg,a,b,options)------>a,b határok
% % %korlát nélküli minimumot keresnek, lokális minimumot térítenek vissza
% % %f(x)=x1^2+x2^2
% % fg=@(x)x(1)^2+x(2)^2
% % %f(z,y,z)=x^2+y^2+z^2
% % f=@(u) u(1)^2+u(2)^2+u(3)^2
% % xmin=fminsearch(f,[2,-1,8])
% % %>>o=optimset--------(l;trehoz egy struktúrát)
% % %>>o=optimset(o,'MaxIter',1000)
% % Xmin=fminsearch(f,[2,-1,8],o)
% % %o=optimset(o,'TolX',1e-3,'TolFum',1e-4)
% % %o=optimset(o,'Display')
% % %plot3---> 3D
f=@(x)(x.*sin(x).^2)
x=-2:0.01:15
plot(x,f(x));
a=5;
b=8;

xmin=fminbnd(f,a,b);
hold on;
plot(xmin,f(x),'*r',a,f(a),'k.',b,f(b),'.k')
grid on;

xo=8;
xmin2=fminsearch(f,xo,o)
plot(xmin2,f(xmin2),'og');

end
 
if m == 2
 
    xo = [0;0];
    x = -3:0.1:3;
    y = x;
    [xr,yr]=mashgrid(x,y);
    mash(xr,yr,xr.*exp(-xr.^2-yr.^2));
    f = @(u) u(1)*exp(-u(1)^2-u(2)^2);
    xmin=fminsearch(f,xo,o);
    hold on;
    plot3(xmin(1),xmin(2),f(xmin),'*r');
    
    figure (2);
    contour (xr,yr,xr.*exp(-xr.^2-yr.^2)
    hold on;
    plot3(xmin(1),xmin(2),f(xmin),'*r')
    
end