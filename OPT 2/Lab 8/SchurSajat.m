function P = SchurSajat(Ad,Bd,Q,R)

H = [Ad+Bd*inv(R)*Bd'*inv(Ad')*Q -Bd*inv(R)*Bd'*inv(Ad');
     -inv(Ad')*Q inv(Ad')];
 
[U,S]=schur(H);
[U,S]=rsf2csf(U,S);
[U,S]=schord(U,S,abs(diag(S)));

n = length(H)/2;
U11=U(1:4,1:n);
U21=U(n+1:2*n,1:n);
P=U21*inv(U11);

end