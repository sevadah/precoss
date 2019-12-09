function y = spm_G2( x, v, pE)
    Nsyl = length(x) - 20;
    % gamma units
    gu = x(9:16,1);

    % syllable units
    ws = x(21 : 20 + Nsyl,1);
    
    % softmax
    w = softmax(ws);

    y(1:8,1) = gu; % gamma units
    y(9,1) = x(20,1); % slow amplitude fluctuations 
    y(10 : 9 + Nsyl,1) = w; % syllable units
    
end

