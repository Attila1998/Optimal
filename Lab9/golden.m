function S = golden(f, x, gr, s0)
i = 0;

while f (x - (i-1)*s0*gr) > f (x - i*s0*gr)
    i = i+1;
    if i==100
        break;
    end
end

if (i >= 3)
    a = (i-2)*s0;
    b = i*s0;
end

if (i < 3)
    a = (i-1)*s0;
    b = i*s0;
end

w = (3-sqrt(5))/2;
c = a+w*(b-a);
d = a+(1-w)*(b-a);

epsz = 10.^(-8);
j=0;
while abs(b-a) >= epsz
    j = j+1; 
    if (j == 100)
        break;
    end
    fc = f(x-c*gr);
    fd = f(x-d*gr);
    
    if (fc >= fd)
        a = c;
        b = d;
        z = c + (1-w) * (b-c);
        c = z;
        b = b;
    end
    if(fc < fd)
        a = a;
        b = d;
        d = c;
        z = a + w*(d-a);
        c = z;
        
    end
end
S = (a+b)/2;


end