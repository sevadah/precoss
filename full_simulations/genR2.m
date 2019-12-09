function R = genR2( dV, sV, bV, s, N)
    %dV values on diagonal
    %sV small values
    %big values
    %sequence

    n = length(s);
    R = ones(N,N);

    for i = 1 : N
        R(i,i) = dV;
    end

    R(s(1),s(n)) = sV;
    R(s(n),s(1)) = bV;

    for i = 1 : n-1
        R(s(i+1),s(i)) = sV;
        R(s(i),s(i+1)) = bV;
    end

end
