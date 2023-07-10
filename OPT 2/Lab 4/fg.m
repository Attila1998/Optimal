function dPv=fg(t,Pv)

global A B Q R
n=length(A);
Pm=reshape(Pv,n,n);
dPm=-Pm*A -A'*Pm+Pm*B*inv(R)*B'*Pm-Q;
dPv=dPm(:);

end