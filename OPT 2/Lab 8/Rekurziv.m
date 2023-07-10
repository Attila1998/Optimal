function P = Rekurziv(Ad, Bd, Q, R, F, N)
    P = F;
    
    for i = N-1 : -1 : 1
       P = Ad'*P*Ad + Q - Ad'*P*Bd*(inv(R) + Bd' * P * Bd)^-1*Bd'*P*Ad;
    end
end