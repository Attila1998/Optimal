%Grafika
t=0:0.01:10;
x=sin(2*pi*0.4*t) %2*pi*f*t T=f/t
%figure(1);
%plot(x,'r');
%figure(2);
%hold on;
%plot(t,x,'k', 'Linewidth',3);
%grid on;
n=10;
y=sin(2*pi*0.2*t);
z=rand(n,length(x));
z=z*0.01;
subplot(2,3,1);
plot(t,x, 'r');
title("X jel:");
xlabel("t");
ylabel("x");
hold on;
subplot(2,3,2);
plot(t,y, 'b');
title("Y jel:");
xlabel("t");
ylabel('y');
hold on;
subplot(2,3,3);
plot(t,z,'y');
title("z jel");
xlabel("t");
ylabel('z');
hold on;
subplot(2,1,2)
plot(t,x+y+z);
title("osszeg:")
xlabel("x");
ylabel('t');
hold on;


figure(3);
x=-3:0.01:3;
y=x;
[sm,ym]=meshgrid(x,y);
mesh(xm,ym,xm.^2+ym.^2);
figure(4);
contour(xm,ym,xm.^2+ym.^2)