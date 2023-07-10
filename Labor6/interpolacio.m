function s2=interpolacio(f,x,gr,s0,h)
%% intervallum kereses
i=0;
while i<100
   i=i+1;
   if f(x-(i-1)*s0*gr)<f(x-i*s0*gr)
       break;
   end
end
if i<3
    a=(i-1)*s0;
else
    a=(i-2)*s0;
end
b=i*s0;
sH=a;
sL=b;
%% interpolacio
M=[sL^3 sL^2 sL 1;
    sH^3 sH^2 sH 1;
    3*sL^2 2*sL 1 0;
    3*sH^2 2*sH 1 0];

E=[f(x-sL*gr);
    f(x-sH*gr);
    (f(x-(sL+h)*gr)-f(x-sL*gr))/h;
    (f(x-(sH+h)*gr)-f(x-sH*gr))/h];
A=inv(M)*E;
a3=A(1);
a2=A(2);
a1=A(3);
s=abs(roots([3*a3 2*a2 a1]));

if f(x-s(1)*gr)<f(x-s(2)*gr)
    s2=s(1);
else
    s2=s(2);
end