function G = gradiens(f,x,h)
G = [];
v = zeros(size(x));
n = length(x);
for i = 1:n
   v(i) = 1;
   G(i,1) = (f(x+h*v) - f(x))/h;
   v(i) = 0;
end