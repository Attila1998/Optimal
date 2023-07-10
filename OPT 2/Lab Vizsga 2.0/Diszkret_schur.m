function P=Diszkret_schur(Ad,Bd,Q,R)
H=[Ad+Bd*R^-1*Bd'*(Ad')^-1*Q -Bd*R^-1*Bd'*(Ad')^-1 ; -(Ad')^-1*Q (Ad')^-1];

[U,S]=schur(H);
[U,S]=rsf2csf(U,S);
[Urendezett,S]=schord(U,S,abs(diag(S)));

n=length(H)/2;
u11=Urendezett(1:n,1:n);
u21=Urendezett(n+1:n*2,1:n);

P=real(u21*u11^-1);