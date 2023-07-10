clear all;
close all;
clc;

x1=-150:1:150;
x2=x1;


%fuggveny
fg=@(x1,x2) -(50-x1).*x1-(64-x2).*x2
f=@(x) -(50-x(1)).*x(1)-(64-x(2)).*x(2)

[x1,x2]=meshgrid(x1,x2);

figure(1)
mesh(x1,x2,fg(x1,x2));

figure(2)
contour(x1,x2,fg(x1,x2));

% kezdeti pont
x0=ginput(1)';
hold on;
plot(x0(1),x0(2),'r*');

m=menu('Valasztott korlat', 'Egyenes', 'Gorbe')

if m==1
 g=@(x) x(1)+(3/2)*x(2)-60 
 x2=-50:50;
 plot(-1.5*x2+60,x2,'r');
end

if m==2
    
    
    
    
    g=@(x)x(1)+(3/2)*x(2)^2-60;  
    x2=-10:10;
    plot(-1.5*x2.^2+60,x2,'r');
end

%% Lagrange resz
L=@(z) f(z)+z(3)*g(z);
Maxiter=300;
Sx=0.01;
Slamb=0.001;
lamb0=17;
h=0.001;
valtozok=[x0;lamb0;f(x0);g(x0)];

for i=1:Maxiter
    
    for j=1:10
        
       
        G=grad_kalk(L,[x0;lamb0],h); 
        
        plot(x0(1),x0(2),'.g');
        
        ujx=x0-Sx*G(1:2);
        
        if norm(f(ujx)-f(x0))<h
            break;
        end
        
        x0=ujx;
        valtozok=[valtozok [x0;lamb0;f(x0);g(x0)]];
        
        
    end
    
    for k=1:10 
        G=grad_kalk(L,[x0;lamb0],h)
        
        lamdauj=lamb0+Slamb*G(3);
        
        
        
        valtozok=[valtozok [x0;lamb0;f(x0);g(x0)]];
        lamb0=lamdauj;
    end
    if norm(G)<0.01
        break;
    end
end
hold on
plot(x0(1), x0(2), 'Og');
figure
subplot(3,1,1)
plot(valtozok(1, :), 'r');
title('Az x1 valtozasa');

subplot(3,1,2)
plot(valtozok(2, :), 'b');
title('Az x2 valtozasa');

subplot(3,1,3)
plot(valtozok(4, :), 'm');
title('A fuggveny kimenetenek valtozasa valtozasa');

figure
subplot(2,1,1)
plot(valtozok(3, :), 'c');
title('A lambda multiplicator  valtozasa');


subplot(2,1,2)
plot(valtozok(5, :), 'g');
title('Az g fuggveny valtozasa');

figure (1)
hold on
for i=1:length(valtozok)

    plot3(valtozok(1,i),valtozok(2,i),valtozok(4,i), '*r');

end
    
    
    
    
    
    





