function P = SchurSajat(A,B,Q,R)

H = [A -B*inv(R)*B';-Q -A'];
[U,S]=schur(H);
[U,S]=rsf2csf(U,S);
[U,S]=schord(U,S,sign(real(diag(S))))
n = length(H)/2;
U11=U(1:4,1:n);
U21=U(n+1:2*n,1:n);
P=U21*inv(U11);

end