t = [0, 0.1, 10];
x = sin(2*pi*0.2*t);
y = sin(2*pi*0.4*t);
z = randn(1, length(x)) * 0.1;

figure(1);

subplot(2, 3, 1);
plot(t, x);
title('x');

subplot(2, 3, 2);
plot(t, y);
title('y');

subplot(2, 3, 3);
plot(t, z);
title('z');

subplot(2, 1, 2);
plot(t, x + y + z);
title('x + y + z');

figure(2);

x=-3:0.01:3;
y= x;
[xm,ym]=meshgrid(x,y);
mesh(xm,ym, xm.^2+ym.^2);

figure(4);
contour(xm,ym, xm.^2+ym.^2);
