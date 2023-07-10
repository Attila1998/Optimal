close all;
clear all;
clc;
Ad=-11;
Bd=-7;
Cd=-7;
Dd=0;

x0=4;
t=0:0.1:50;
yref= 20*sin(t);

figure(1);
plot(t,yref,'Linewidth',2);

R=2; %1 bemenet
Q=500; %1kimenet

Fi=Ad;
Ga=Bd;

se=abs(eig(Ad)) % a rendszer instabil

if rank(ctrb(Ad,Bd)) == rank(Ad)
    disp('Iranyithato')
else
    disp('Nem iranyithato')
end

if rank(obsv(Ad,Cd)) == rank(Ad)
    disp('Megfigyelheto')
else
    disp('Nem megfigyelheto')
end

    Pdare=dare(Fi, Ga,Cd'*Q*Cd,R)
    P=Diszkret_schur(Ad,Bd,Cd'*Q*Cd,R)

    K1=-(R+Ga'*P*Ga)^-1*Ga'*P*Fi; %szabalyzo visszacsatolt erositese
    K2=(R+Ga'*P*Ga)^-1*Ga'*((1-Fi-Ga*K1)')^-1*Cd'*Q; %szabalyzo elorecsatolt erositese

    % ciklus szimulaciot + szabalyozast
    yref=yref';
    for i=1:length(t)
       u(i)=K1*x0+K2*yref(i);
       y(i)=Cd*x0;
       ujxx=Fi*x0+Ga*u(i);
       x0=ujxx;
    end

    figure(1)
    hold on
    plot(t,y)
    title("Vegtelen horizont szabalyzott kimenetek es referenciak");
    legend('Referencia','kimenet');

%     figure(2)
%     hold on
%     plot(yref,y);
%     legend("referencia", "szabalyzott kiemenet");
%     title("Vegtelen horizont szabalyzott kimenete es referencia");