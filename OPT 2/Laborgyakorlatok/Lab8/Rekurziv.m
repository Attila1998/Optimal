function [P]=Rekurziv(Ad,Bd,Q,R,F,N)
   P=F; %horizont
   
   for i=N-1: -1: 1
     
         P = Ad'*P*Ad + Q - Ad'*P*Bd*(R + Bd' * P * Bd)^-1*Bd'*P*Ad;
       
   end
   



end