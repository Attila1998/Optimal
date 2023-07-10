function [grad]=grad_kalk(f,x,h)

n=length(x); %hany valtozos a fuggveny

v=zeros(n,1);
for i=1:n
    v(i)=1;
    grad(i,1)=(f(x+h*v)-f(x))/h;
    v(i)=0;
    



end