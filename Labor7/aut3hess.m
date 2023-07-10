function H = aut3hess(f, x, h)
    n = length(x);
    v = zeros(n, 1);
    
    for i = 1 : n
       v(i) = 1;
       H(:, i) = (aut3grad(f, x + h*v, h) - aut3grad(f, x, h)) ./ h;
       v(i) = 0;
    end
end

