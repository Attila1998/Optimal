clear ALL;
close ALL;
clc;
A=[0.8 0.1 0; 0.01 -0.9 0.04 ; 0.05 -0.01 0.2];
B=[1 0.1; 2 5; -0.2 2];
C=eye(size(A));
D=zeros(size(A,1),size(B,2));
x0=[0 1 2]';
ts=0.1;
t=0:ts:10;
u1=4*ones(size(t));
u2=square(0.5*t);
zaj=randn(3,length(t))*0.2;

y=lsim(ss(A,B,C,D,ts),[u1; u2]',t,x0);
yz=y+zaj';
plot(t,y,t,yz);
%% offline becsles
s1=0;
s2=0;

u=[u1' u2'];
x=yz;
for i=2:length(t)
 
fi=[x(i-1,:) u(i-1,:)]';

s1=s1+fi*fi';
s2=s2+fi*x(i,:);    
    
end

teta1=inv(s1)*s2
Abecsultoff=teta1(1:3,1:3)';
Bbecsultoff=teta1(4:5,1:3)';
%% online

% inicializalas a becslonek
Q0=randn(5,3);
th0=Q0;% teta0
P0=80*eye(5);
P0o=P0;% kezdeti szoras matrix
teta=Q0(:);
pnyoma=trace(P0);
hiba=[0 0 0];
ybecs=[0 0 0];
ymert=x0';
for i=2:length(t)
	% meres
	ujx=A*x0+B*u(i,:)'+zaj(:,i);
    ymert=[ymert ;ujx'];
	% becsles
        fi=[x0' u(i-1,:)]';
        yb=fi'*Q0;
	    E=ujx'-yb;
        K=(P0*fi)/(1+fi'*P0*fi);
        Puj=(eye(5)-K*fi')*P0;
        P0=Puj;
        Quj=Q0+K*E;
        Q0=Quj;
        teta=[teta Q0(:)];
        pnyoma=[pnyoma trace(P0)];
        x0=ujx;
        hiba=[hiba; E];
        ybecs=[ybecs; yb];
        
end
Abecsulton=Q0(1:3,1:3)';
Bbecsulton=Q0(4:5,1:3)';
figure(1)
subplot(311); plot(t,u);legend('bemenert');
subplot(312);plot(t,ymert,t,ybecs); legend('mert', 'becsult');
subplot(313); plot(t,hiba);legend('becslesi hiba')
figure(2);

subplot(211);
plot(t,teta);legend('teta');

subplot(212);
plot(t,pnyoma);legend('szorasmatrix nyoma');