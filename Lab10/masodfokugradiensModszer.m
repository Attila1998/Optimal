close all; clear all; clc;

fg = @(x) 5*x(1).^2 + 6*x(2).^2 + 3*x(1)*x(2) + 7;
x1 = -15:0.1:15;
x2 = -15:0.1:15;
m=menu('Menu','Newton Raphson','Kvazi Newton', 'Levenberg')
[X Y] = meshgrid(x1,x2);

Z = 5*X.^2 + 6*Y.^2 + 3*X.*Y + 7;
mesh(X, Y, Z);
hold on;
figure(2);
contour(X,Y,Z);
hold on;
x = ginput(1)';
plot(x(1), x(2),'*b');

nMax = 300;
S = 1;
h = 10^(-3);
epsz = 10^(-8);
fmin = fg(x);
t = [x(1); x(2);fmin]
s0 = 10^(-3); 
for i=1:nMax
   % gradf = [16*x(1) + 5*x(2); 18*x(2) + 5*x(1)-3];
    gradf2 = gradiens(fg, x, h);
    if m ==1 % newton-raphson
        hessM = hessf(fg, x, h);
        M = -inv(hessM) * gradf2;
    end
    if m == 2%kvazi -newton
        hj= 0.1;%kicsi szam
        while (1)
          hessM = hessf(fg, x, hj);
          if det(hessM) ~= 0 && gradf2' * hessM * gradf2 > 0
              break;
          else
              hj = hj/2;
          end
        end
            M = -inv(hessM) * gradf2;
    end
    gamma = 200;
    if m == 3 %levenberg 
        Hcs = inv((gradf2 * gradf2' + gamma*eye(2))) * (fg(x));%megadott keplet
         M = -(Hcs) * gradf2;%irany meghatarozasa
    end
   
    %S = ((gradf' * gradf) / (gradf' * hessM * gradf));
    %S = golden(fg, x,  gradf2, s0);
   % S = interpolaciosm(fg, x,  gradf2, s0, h);
%    M = -inv(hessM) * gradf2;

    x1 = x + S*M;
    x = x1;
    t = [t [x(1); x(2); fmin]];
    plot(x(1), x(2),'*r');
    
    %megallasi feltetel
    if (norm(gradf2) <= epsz)
        break;
    end
    
    %megallasi feltetel
    if((norm(x - x1) <= epsz) && (abs(fg(x) - fg(x1)) < 0))
        break;
    end
    
    plot(x(1), x(2),'*g');
   
end

plot(t(1,:), t(2, :),'k' );