clear all;
close all;
clc;


m1=50
m2=30
k=0.5

x0=[5 10 2 7]
A=[0 1 0 0; -k/m1 0 k/m1 0; 0 0 0 1; k/m2 0 -k/m2 0]
B=[0; 1; 0; 0]
C=[1 0 0 0]
D=0;

R=0.1; % mert 1 bemenet van, ezert 1 dimenzio
Q=100; % koveto szabalyzo

t=0:0.1:10;
u(1:size(t,2))=10;

rendszer=ss(A,B,C,D);
[y, t,x]=lsim(rendszer,u,t)
plot(t,y);
title('Szimulacio')
hold on;
plot(t,x(:,3))
legend('X1 ', 'X2')

opcio=menu('Tipus', 'Allapot utani', 'Koveto')

%% Csak hogy a simulink ismerje a változókat
if opcio==1 || opcio==2
    %% Állapot utáni szabályzó erõsítése
    Q=100*eye(4)  %% mert 4 allapot van, es allapot utani szabalyzot irunk
    P=are(A,B*R^-1*B',Q);
    K=inv(R)*B'*P;
    
    %% Követõ szabályzó erõsítése
    
    Q=100; % mert 1 kimenetunk van, es koveto szabalyzo  
    P=are(A,B*R^-1*B',C'*Q*C);
    Kfb=-(R^-1*B'*P) %% feed back
    Kff = -(R^-1*B'*((A-B*R^-1*B'*P)')^-1)*C'*Q;
    
    
end


if opcio==1
    Q=100*eye(4)  %% mert 4 allapot van, es allapot utani szabalyzot irunk
    P=are(A,B*R^-1*B',Q);
    K=inv(R)*B'*P;
   
    A_zart=A-B*K;
    B_zart=zeros(size(B));

    [y,t,x]=(lsim(ss(A_zart,B_zart,C,D),u,t,x0));

figure
    subplot(3,1,1)
    plot(t,x(:,1), t,x(:,3));
    title('Elmozdulas zárt hurokban');
    
    hold on;
    legend('elso ', 'masodik')

    subplot(3,1,2)
    plot(t,x(:,2), t,x(:,4));
    title('Sebesseg zárt hurokban');
   
    hold on
   

    subplot(3,1,3)
    plot(t,-K*x');
    title('Vezérlõ  jel zárt hurokban');

   
    run rugos_rendszer_new
    
end

if opcio==2
    Q=100; % mert 1 kimenetunk van, es koveto szabalyzo  
    P=are(A,B*R^-1*B',C'*Q*C);
    Kfb=-(R^-1*B'*P) %% feed back
    Kff = -(R^-1*B'*((A-B*R^-1*B'*P)')^-1)*C'*Q;
    A_zart=A+B*Kfb;
    B_zart=B*Kff;
    z=10*sin(t);
    x0=x0*0;
    [y,t,x]=(lsim(ss(A_zart,B_zart,C,D),z,t,x0));
    
     figure
    subplot(3,1,1)
    plot(t,x(:,1), t,x(:,3));
    title('Elmozdulas zárt hurokban');
    
    hold on;
    plot(t,z,'.g');
    legend('elso ', 'masodik','eloirt palya')

    subplot(3,1,2)
    plot(t,x(:,2), t,x(:,4));
    title('Sebesseg zárt hurokban');
   
    hold on
   

    subplot(3,1,3)
    plot(t,-Kfb*x'+Kff*z');
    title('Vezérlõ  jel zárt hurokban');

    run rugos_rendszer_new
    
end


