clear all
close all;
clc;

x1 = -2 : 0.1 : 2;
x2 = x1;
h = 0.01;

fg = @(x1, x2)((8*x1.^2+10*x2.^2) - 3*x1.*x2+9);
f = @(x)((8*x(1).^2+10*x(2).^2) - 3*x(1).*x(2)+9);

figure(1);
[x1, x2] = meshgrid(x1, x2);
mesh(x1, x2, fg(x1, x2));

figure(2);
contour(x1, x2, fg(x1, x2));
x0 = ginput(1)';
hold on;
plot(x0(1), x0(2), '*r');

m = menu('modszer', 'masodrendu', 'konjugalt');

if m == 1
    m1 = menu('valtozat', 'Newton-modszer', 'Kvazi Newton', 'Levenberg', 'David-Fletcher');
    S = 1;    
    
    for i = 1 : 100
       gr = aut3grad(f, x0, h);
       
       if m1 == 1
           H = aut3hess(f, x0, h);
           Hi = inv(H);
       end
       
       if m1 == 2
          h_ = 0.25;
          H = aut3hess(f, x0, h_);
          
          while(1)
           if (det(H) == 0 || gr'*inv(H)*gr < 0) 
              h_ = h_/2;
            end
          end
          
          Hi = inv(H);
       end
       
       if m1 == 3
           gamma0 = 200;
           Hi = inv(gr * gr' + gamma0*eye(2)) * f(x0);
       end
       
       x = x0 - S*Hi*gr;
       
       if norm(x - x0) < 0.0001
           break
       end
       
       x0 = x;
       plot(x0(1), x0(2), '*');
    end
end













