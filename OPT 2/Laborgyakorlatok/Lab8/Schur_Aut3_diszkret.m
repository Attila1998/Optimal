function [P]=Schur_Aut3_diszkret(Ad,Bd,Q,R)

H = [Ad+Bd*inv(R)*Bd'*inv(Ad')*Q -Bd*inv(R)*Bd'*inv(Ad');
     -inv(Ad')*Q inv(Ad')];
 
 
[U,S]=schur(H);
[U,S]=rsf2csf(U,S); %% diagonizalja az s-t
[Urendezett,S]=schord(U,S,abs(real(diag(S)))); % rendezi a sajat vektorokat

n=length(H)/2;
U11=Urendezett(1:n, 1:n);
U21=Urendezett(n+1:n*2, 1:n);

P=real(U21*U11^-1);

end