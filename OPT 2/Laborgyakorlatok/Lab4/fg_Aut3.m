function [dPv]=fg_Aut3(t,P)
    global A B Q R

    n=length(A);
    Pm=reshape(P,n,n); 
    dPm=-Pm*A-A'*Pm+Pm*B*R^-1*B'*Pm-Q;%diff ricatti
    dPv=dPm(:);
    % azert kell ez a fuggveny, mert az ode45 csak vektort fogad el
    % bemenetnek
end