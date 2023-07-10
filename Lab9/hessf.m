function H = hessf(f,x,h)
H = [];
v = zeros(size(x));
n = length(x);
for i = 1:n
   v(i) = 1;
   H(:,i) = (gradiens(f,x+h*v, h) - gradiens(f,x,h))/h;
   v(i) = 0;
end