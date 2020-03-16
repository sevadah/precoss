function D = reArrangeMat(R, Nr)
    D = zeros(size(R));
    N = size(R,1);
    r_range = 1 : Nr;
    s_range = Nr+1 : N-1;
    
    
    B = R(r_range, r_range);
    A = R(s_range, s_range);
    
    C1 = R(Nr+1 : N-1, 1 : Nr);
    C = R(1 : Nr, Nr+1 : N-1);
    
    D(1 : Nr, r_range) = B;
    
    D(Nr+1, r_range) = R(N, r_range);
    D(Nr+2 : end, r_range ) = C1;
    
    D(Nr+1, Nr+1) = R(N,N);
    
    D(r_range, Nr+1) = R(r_range, N);
    D(Nr+2 : end, Nr+1) = R(Nr+1 : N-1, N);
    
    D(1:Nr, Nr+2:end) = C;
    
    D(Nr + 1, Nr+2 : end) = R(N, Nr+1 : end-1);
  
    D(Nr+2 : end, Nr+2 : end) = A;


end

