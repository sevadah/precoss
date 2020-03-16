function y = spm_G2_theta( x, v, pE)
    % syllable number - number of all hidden states minus
    % the number of hidden states that not correspond to syllable units
    % the number of those units is sentence-independent
    % the number of syllable units is variable
    % x(1:16) - gamma units
    % x(17) - gamma speed/duration
    % x(18-19) - exogenous theta oscillation
    % x(20) - slow amplitude modulation

    Nsyl = length(x) - 20;
    
    % gamma units
    gu = x(9:16,1);
    
    % syllable units
    ws = x(21 : 20 + Nsyl,1);
    
    % softmax
    w = softmax(ws); 

    %% output
    
    y(1:8,1) = gu; % gamma units
    y(9,1) = x(20,1); % slow amplitude modulation
    y(10 : 9 + Nsyl,1) = w; % syllable units
    
end

