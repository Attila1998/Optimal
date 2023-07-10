clear all;
close all;
clc

x1 = -2:0.1:2
x2 = x1;
fg = @(x1,x2)((8*x1.^2+10*x2.^2)-3*x1.*x2+9);
f = @(x)((8*x(1).^2+10*x(2).^2)-3*x(1).*x(2)+9);
[x1,x2] = meshgrid(x1,x2);
figure;
mesh(x1,x2,fg(x1,x2));
figure;
contour(x1,x2,fg(x1,x2));
x0 = ginput(1);
hold on;
plot(x0(1),x0(2),'*r');


h = 0.01;

m = menu('modszer','masodrendu','konjugalt');
if m == 1
    m1 = menu ('valtozat','Newton-Raphson','Kvazi-newton','Levenderg','David-Fletcher');
    S = 1;
    for i = 1:100
        gr = lab5Grad(f,x0,h);
        if m1 == 1
            M = fgH(f,x0,h) %Hesszmátrix
            Hi = inv(H);
        end
        if m1 == 2
             h_ = 0,5;
             while (1)
                 H = fgH(f,x0,h);
                 if ((det(H) == 0) || (gr'*inv(H)*gr > 0))
                     h_ = h_/2;
                 else
                     break;
                 end
             end
              Hi = inv(H);
        end
        
        if m1 == 3
            gamma0 = 200;
            Hi = inv(gr * gr' + gamma0 * eye(2)) * f(x0);
        end
        ujx = x0 - S*Hi*gr;
        if norm(ujx - x0) < 0.0001
            break;
        end
        x0 = ujx;
        plot(x0(1),x0(2));
    end
    
end