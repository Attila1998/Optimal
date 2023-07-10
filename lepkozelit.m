function [s]=lepkozelit(x,s0,h)
i=0;
while (1)
   i=i+1;
   xuj=x-i*s0*grad(x,h);
   m(i)=fff(xuj);
   if i~=1   
      if m(i)>m(i-1)  break;    end;
   end
end;
if i>=3
     s=(i-2)*s0;     
else
    s=(i-1)*s0;     
end;