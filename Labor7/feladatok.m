clear all;
close all;
clc;

disp("Valasszon egy modszert: ");
disp("1. Elsofoku gradiens");
disp("2. Interpolacio");
disp("3. Aranymetszes");
disp("4. Felezomodszer")
choiceM = input('> ');

disp("Valasszon egy fuggvenyt: ")
f = @(x) x(1)^2 + x(2)^2 + x(1)*x(2) + 2*x(1);
disp('1.')
disp(f);
f = @(x) x(1)*exp(-x(1)^2-x(2)^2);
disp('2.')
disp(f);
f = @(x) 10*x(1)^2 + 5*x(2)^2 + 8*x(3)^2 + x(1)*x(2) - x(2)*x(3) + 7;
disp('3.')
disp(f);
choiceF = input('> ');

if choiceF == 1
    f = @(x) x(1)^2 + x(2)^2 + x(1)*x(2) + 2*x(1);
elseif choiceF == 2
    f = @(x) x(1)*exp(-x(1)^2-x(2)^2);
elseif chioceF == 3
    f = @(x) 10*x(1)^2 + 5*x(2)^2 + 8*x(3)^2 + x(1)*x(2) - x(2)*x(3) + 7;
end

xk = [4; 6];
allCords = [xk(1), xk(2), f(xk)];

MaxIter = 100;
xTol = 1e-3;
funTol = 1e-3;

h = 0.001;
S = 0.01;
S0 = 0.01;

x = -10 : 0.01 : 10;
y = -10 : 0.01 : 10;
[xr, yr] = meshgrid(x, y);

figure(1);
contour(xr, yr, xr.^2 + yr.^2 + xr.*yr + 2.*xr);

for i = 1 : MaxIter
    xk_last = xk;
    gr = aut3grad(f, xk, h);
    H = aut3hess(f, xk, h);
    
    if choiceM == 1
       S = (gr' * gr) / (gr' * H * gr);
    elseif choiceM == 2
        S = interpolacio(f, xk, gr, S0, h);
    elseif choiceM == 3
        S = golden(f, xk, S0, h);
    elseif choiceM == 4
        S = felezo(f, gr, xk, 0.01, S0);
    end

    M = -gr;
    xk = xk + S * M;
    
    hold on;
    plot(xk(1), xk(2), 'r*');
    allCords = [allCords; xk(1), xk(2), f(xk)];
end

figure(2);
plot3(allCords(:, 1), allCords(:, 2), allCords(:, 3), 'r');
hold on;
mesh(xr, yr, xr.^2 + yr.^2 + xr.*yr + 2.*xr);

disp("Minium pont: ")
disp(xk);


