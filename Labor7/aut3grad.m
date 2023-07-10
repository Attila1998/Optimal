function [gr] = aut3grad(f, x, h)
    n = length(x);
    v = zeros(n, 1);
    gr = zeros(n, 1);
    
    for i = 1 : n
        v(i) = 1;
        gr(i, 1) = (f(x + h.*v) - f(x)) ./ h;
        v(i) = 0;
    end
end
