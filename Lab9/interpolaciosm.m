function Sopt = inetrpolaciosm(f, x, gr, s0, h)% fg, x pont , gradiens, h-perturbacio
i = 0;

while f (x - (i-1)*s0*gr) > f (x - i*s0*gr)
    i = i+1;
    if i==100
        break;
    end
end

if (i >= 3)
    sL = (i-2)*s0;
    sH = i*s0;
end

if (i < 3)
    sL = (i-1)*s0;
    sH = i*s0;
end

f1 = f (x - sL*gr);
f2 = f(x - sH*gr);
f3 = (f (x - (sL + h) *gr) - f(x - sL*gr))/h;
f4 =(f (x - (sH + h) *gr) - f(x - sH*gr))/h;

F = [f1; f2; f3; f4];
M = [sL^3 sL^2 sL 1; sH^3 sH^2 sH 1; 3*sL^2 2*sL 1 0; 3*sH^2 3*sH 1 0];
A = inv(M)*F;

S = roots([3*A(1) 2*A(2) A(3)])

    if f(x - S(1)*gr) < f(x - S(2)*gr)
       Sopt = S(1);
    end
    if f(x - S(1)*gr) > f(x - S(2)*gr)
      Sopt = S(2);
        
    end
end