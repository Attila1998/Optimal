function Ppotter =  PotterDiszkret(Ad,Bd,Q,R)

H = [Ad+Bd*inv(R)*Bd'*inv(Ad')*Q -Bd*inv(R)*Bd'*inv(Ad');
     -inv(Ad')*Q inv(Ad')];

[V,E] = eig(H);

Vr=[]; %rendezett mátrix

for i = 1:length(V)
    if real(E(i,i)) < 0
        Vr=[V(:,i) Vr];
    else
        Vr=[Vr V(:,i)];
    end     
end

n = length(H)/2;

V11=Vr(1:n,1:n);
V21=Vr(n+1:2*n,1:n);

Ppotter = real(V21*inv(V11));

end