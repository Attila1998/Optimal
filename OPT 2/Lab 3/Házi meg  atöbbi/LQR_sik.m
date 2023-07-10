clear all;
close all;
clc;

M = 25;
mu = 4;

A = [0 1 0 0;
     0 -mu/M 0 0;
     0 0 0 1;
     0 0 0 -mu/M];
B = [0 0;
      1/M 0;
      0 0;
      0 1/M];
  
C = [1 0 0 0;
      0 0 1 0];
D = [0 0;
       0 0];
x0 = [100; 20; 50; 20];

Ts = 0.1;
t = 0 : Ts : 10;

u = [10 * ones(1, length(t));
    10 * ones(1, length(t))];

[y, t, x] = lsim(ss(A, B, C, D), u, t, x0);

% figure;
% subplot(3, 1, 1);
% plot(t, x(:, 1), t, x(:, 3));
% title("elmozdulas");
% legend("x_d", "y_d");
% 
% subplot(3, 1, 2);
% plot(t, x(:, 2), t, x(:, 4));
% title("sebesseg");
% legend("v_x", "v_y");
% 
% subplot(3, 1, 3);
% plot(t, u);
% title("rendszer bemenet");
% 
% figure;
% plot(x(:, 1), x(:, 3));

R = 1;
Q = eye(4) * 40;

% Ricatti egyenlet megoldasa
P = are(A, B*inv(R)*B', Q);

K = inv(R) * B' * P;

Azart = A - B * K;
Bzart = zeros(size(B));
[y, t, x] = lsim(ss(Azart, Bzart, C, D), u, t, x0);

figure;
subplot(3, 1, 1);
plot(t, x(:, 1), t, x(:, 3));
title("elmozdulas");
legend("x_d", "y_d");

subplot(3, 1, 2);
plot(t, x(:, 2), t, x(:, 4));
title("sebesseg");
legend("v_x", "v_y");

subplot(3, 1, 3);
plot(t, u);
title("rendszer bemenet");

figure;
plot(x0(1), x0(3), 'og', x(:, 1), x(:, 3), '-b', 0, 0, 'xr');
title("elmozdulas");
legend("kezdopont", "palya", "celpont");
grid on;