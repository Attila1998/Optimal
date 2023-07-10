function P = NewtonAut3(A, B, Q, R)

[n,m]=size(A)
P = are(A,B*inv(R)*B',Q); %veletlenszeru p
P = P+rand(size(P))*0.1;
P = (P+P')./2
[np,mp]=size(P)

if mp ~=m || np~=n || norm(P-P')~=0
    'Rossz a kezdeti p'
    return
end

for i=1:n
    if det(P(1:i,1:i))<0
       'Rossz a kezdeti p'
       return
    end
end

