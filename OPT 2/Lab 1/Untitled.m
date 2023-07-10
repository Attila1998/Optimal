clear all;
close all;
clc;

w = 4;
x0 = [2;6];
ts = 0.01;

A = [0 w; -w 0];
B = [0; 1]
C = eye(2);
D = [0;0];

%% folytonos allapotteres modell
sys = ss(A,B,C,D);

%% mintevetelezes
sysD = c2d(sys,ts);
[Ad, Bd, Cd, Dd] = ssdata(sysD);
e = 0.1;
t = 0:ts:15
tarolo = [x0;0];
for i=1:length(t) - 1
    u = -sign(x0(2));
    x0 = Ad*x0 + Bd*u;
    tarolo = [tarolo [x0;u]];
    if (abs(x0(1))<e && abs(x0(2))<e)
        break;
    end
end
n = length(tarolo);

plot(t(1:n),tarolo(1:2,:));

figure(2);
plot(t(1:n),tarolo(3,:));
plot(tarolo(1,:),tarolo(2,:));