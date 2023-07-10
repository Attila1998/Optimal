function P = potter_Fulop(A,B,Q,R)

H = [A -B*R^-1*B';
     -Q -A'];

[sv,se] = eig(H);

svrendezett = [];

% rendezes
for i=1:length(sv)
    if (real(se(i,i)) < 0)
        svrendezett = [sv(:,i) svrendezett];
    else
        svrendezett = [svrendezett sv(:,i)];
    end
end

n = length(H)/2;

% particionalas
V11 = svrendezett(1:n,1:n);
V21 = svrendezett(n+1:n*2,1:n);

P = real(V21*V11^-1);

end