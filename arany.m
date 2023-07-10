function s2=arany(f,x,gr,s0)
%intervallum kereses
i=0;
while i<100
   i=i+1;
   if f(x-(i-1)*s0*gr)<f(x-(i)*s0*gr)
    break;
   end
    
end
if i<3
    a=(i-1)*s0
else
    a=(i-2)*s0
end
b = i*s0;
c = a+w*(b-a);
d = a+(1-w)*(b-a);

i = 0;
while i < 100
epszilon = 1e-5;
fc = f(x-c*gr);
fd = f(x-d*gr)

if fc>fd %uj intervallum c es b
    z = c +(1-w)*(d-c);
    a = c;
    c = d;
    d = z;
else %uj untervallum a es d
    z = a + w*(d - a);
    b = d;
    d = c;
    c = z;
    if abs(b - a)<epszilon
        break;
    end
  end

end