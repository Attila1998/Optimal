function [P]=Schur_Aut3(A,B,Q,R)

H=[A  -B*R^-1*B'; -Q -A'];
[U,S]=schur(H);
[U,S]=rsf2csf(U,S); %% diagonizalja az s-t
[Urendezett,S]=schord(U,S,sign(real(diag(S)))); % rendezi a sajat vektorokat

n=length(H)/2;
U11=Urendezett(1:n, 1:n);
U21=Urendezett(n+1:n*2, 1:n);

P=real(U21*U11^-1);

end