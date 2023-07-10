function Sopt = felezo(f,gr,x0,alfa,s0)
theta=@(s0)(f(x0-s0*gr)-f(x0)+s0*(1-alfa)*gr'*gr);
thetafelul=@(s0)(f(x0-s0*gr)-f(x0)+s0*alfa*gr'*gr);
i=0;
while i < 100
    i=i+1;
    if theta(i*s0) >= 0
        b=i*s0;
        break;
    end
end

if theta(i*s0) == 0
    Sopt = i*s0;
end

while i > 0
    i=i-1;
    if thetafelul(i*s0) <= 0
        a=i*s0;
        break;
    end
end

if theta(i*s0) == 0
    Sopt = i*s0;
end

for i=1:100
    psi=(a+b)/2;
    if theta(psi)>0 && thetafelul(psi)>0
        b=psi;
    end
    if theta(psi)<0 && thetafelul(psi)<0
        a=psi;
    end
    if theta(psi)>0 && thetafelul(psi)<0
        Sopt=psi;
    end
end