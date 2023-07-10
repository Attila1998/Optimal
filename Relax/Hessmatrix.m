function [Hess]=Hessmatrix(f, x, h)

    n=length(x);
    v=zeros(n,1);
    for i=1:n
        v(i)=1;
        Hess(:,i)=(grad_kalk(f, x+h*v, h)-grad_kalk(f,x,h))/h; % masodlagos derivaltakbol allo matrix
                                                            % arra pedig a
                                                            % gradienst
                                                            % hasznaljuk
        v(i)=0;
        
    end
        



end