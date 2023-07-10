clear all;
close all;
clc;

Th = 2;
Tp = 1;
Tv = 0.5;

k = 10;

Ts = 0.2;

A = [-1/Th  k/Th -k/Th;
    0 -1/Tp 0 ;
    0 0 -1/Tv];

B = [0 0;
    1/Tp 0;
    0  1/Tv];

C = [1 0 0];

D = [0 0];

Rendszer = ss(A,B,C,D);
DiszkretRendszer = c2d(Rendszer,Ts);
[Ad,Bd,Cd,Dd]= ssdata(DiszkretRendszer);

%% Szabalyzó tervezés
R =5*eye(2); %bemeneteket súlyoz,pozitív definit

Q = 100*eye(3); %állapotokat súlyoz , Q>R

P = dare(Ad,Bd,Q,R);

K = -inv(R+Bd'*P*Bd)*Bd'*P*Ad;

%% Nyilt hurok szimulcio
t = 0:Ts:10;
u1 = 5*ones(size(t));
u2 = 12*ones(size(t));
u =[u1;u2]';
x0 = [2 3 5]';
x0k = [2 3 5]';
[y,t,x] = lsim(DiszkretRendszer,u,t,x0);

figure;
stairs(t,x);
title("Nyilt hurok szimulacio");

%% Zart rendszer szimuláció

Adz = (Ad+Bd*K);
Bdz = zeros(size(Bd));
Cdz = Cd;
Ddz = Dd;

ZartRendszer = ss(Adz,Bdz,Cdz,Ddz,Ts);
[y,t,x] = lsim(ZartRendszer,u,t,x0);
figure;
subplot(2,1,1);
plot(t,x);
title("Zart hurok szimulacio allapotok");
subplot(2,1,2);
plot(t,K*x');
title("Zart hurok szimulacio szablyelek");
%%
m = menu('valtozat','nyilthurok','zarthurok');

tarolo = x0;
tarolo2 = [K*x0];
for i = 1:length(t)-1
   if(m == 1)
       uc = u(i,:)';
   else
       uc = K*x0;
   end
   x0 = Ad*x0+Bd*uc;
   tarolo = [tarolo,x0];
   tarolo2 = [tarolo2,uc];
end

figure;
subplot(2,1,1);
plot(t,tarolo);
title("Zart hurok forral allapotok");
subplot(2,1,2);
plot(t,tarolo2);
title("Zart hurok forral allapotok");