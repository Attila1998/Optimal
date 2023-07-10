clear all;
close all;
clc;

%% Rendszer matrixok
Ad=[2 0.1 3 4; 1 -1 0 1; -2 0 3 1; 0 1 -2 5]
Bd=[0 1; 1 1; 0 1; 1 0];
Cd=[1 1 -2 3];
D=zeros(1,2);

%% Stabilitas
[Lamda]=eig(Ad)
abs(Lamda)

%% Szabalyzohatosag

szab_matrix=ctrb(Ad,Bd)
meret=rank(szab_matrix);
if meret==size(Ad,1)
    disp('Szabalyozhato')
else
    disp('Nem szabalyozhato')
end

megfigy_matrix=obsv(Ad,Cd);
meret2=rank(megfigy_matrix);

if meret2==size(Ad,1)
    disp('Megfigyelheto')
else
    disp('Nem megfigyelheto')
end

%% Szabalyzo tervvezes
R = 0.1*eye(2);    % bemeneteket sulyoz, szimmetrikus, pozitiv definit
               % legtisztabb: valahanyszor eye
Q = 100* eye(4);       % allapotokat sulyoz
                     % Q>R
                     
Pd = dare(Ad,Bd, Q,R);

Ppotter = PotterDiszkret(Ad,Bd,Q,R)

P = SchurSajat(Ad,Bd,Q,R)

%% Rekurziv

F = zeros(4);

N = 5; %horizont

P = Rekurziv(Ad, Bd, Q, R, F, N);

%hiba szamitas
error = norm(P - Pd)

K = -inv(R+Bd'*P*Bd)*Bd'*P*Ad;

%% Nyilt hurok szimulcio
Ts = 0.1;
t = 0:Ts:10;
u1 = 5*ones(size(t));
u2 = 12*ones(size(t));
u =[u1;u2]';
x0 = [2 3 5 6]';
[y,t,x] = lsim(ss(Ad,Bd,Cd,D,Ts),u,t,x0);

figure;
stairs(t,x);
title("Nyilt hurok szimulacio");

%% Zart rendszer szimuláció

Adz = (Ad+Bd*K);
Bdz = zeros(size(Bd));
Cdz = Cd;
Ddz = D;

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