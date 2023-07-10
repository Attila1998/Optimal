function S = golden(f, xk, gr, S0)
   i = 0;
   MaxIter = 100;
   
   while i < MaxIter
      i = i + 1;
      
      if f(xk-(i - 1) * S0 * gr) < f(xk - i * S0 * gr)
          break;
      end
   end
   
   if i < 3
       a = (i - 1) * S0;
   else
       a = (i - 2) * S0;
   end
   
   b = i * S0;
   w = (3 - sqrt(5)) / 2;
   
   c = a + w * (b - a);
   d = a + (1 - w) * (b - a);
   
   i = 0;
   epsilon = 1e-5;
   
   while i < MaxIter
   fc = f(xk - c * gr);
   fd = f(xk - d * gr);
   
   if fc >= fd % uj intervallum c es b
      z = c + (1 - w) * (b - c);
      a = c;
      c = d;
      d = z;
   else % uj intervallum a es d
      z = a + w * (d - a);
      b = d;
      d = c;
      c = z;
   end
   i = i + 1;
   
   if abs(b - a) < epsilon
      break; 
   end
   end
   
   S = (a + b) / 2;
end



