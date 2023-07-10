function Ppotter =  pottersajat(A,B,Q,R)

H = [A -B*inv(R)*B';
    -Q -A']

[V,E] = eig(H)

Vr=[]; %rendezett mátrix

for i = 1:length(E)
    if real(E(i,i)) < 0
        Vr=[V(:,i) Vr];
    else
        Vr=[Vr V(:,i)];
    end     
end

V11=Vr(1:4,1:4)
V21=Vr(5:8,1:4)

Ppotter = V21*inv(V11)

end