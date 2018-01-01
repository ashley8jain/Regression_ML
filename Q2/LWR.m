function [LWRx,LWRy] = LWR(X,y,m,n,tau)
       
    theta = zeros(n, 1);
    W = zeros(m,m);
    
    %%%%%%%%%%%%%%%%%%%%%%%% computing LWR  %%%%%%%%%%%%%%%%%%%
    
    %set of query point
    LWRx = min(X(:,2)):0.2:max(X(:,2));
    
    %calculating theta values for every query points
    for q = 1:size(LWRx,2)
        w = exp((-(X(:,2)-LWRx(q)).^2)/(2*(tau^2)));
        W = diag(w);
        theta = pinv(X'*W*X)*X'*W*y;
        LWRy(q) = theta(1)+theta(2)*LWRx(q);
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end