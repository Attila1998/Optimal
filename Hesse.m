function H=Hesse(f,x,h)
n=length(x);
v=zeros(n,1);
H=zeros(n);
for i=1:n
    v(i)=1;
    H(:,i)=(grad(f,x+h*v,h)-grad(f,x,h))/h;
    v(i)=0;
end