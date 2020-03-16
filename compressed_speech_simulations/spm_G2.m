function y = spm_G2( x, v, pE)
    Nsyl = length(x) - 17;
    
    % gamma units
    gu = x(9:16,1);
    
    % syllable units
    ws = x(18 : 17 + Nsyl,1);
    
    % softmax
    w = softmax(ws); 

    %% output
    
    y(1:8,1) = gu; % gamma units
    y(9 : 8 + Nsyl,1) = w; % syllable units
    
end

