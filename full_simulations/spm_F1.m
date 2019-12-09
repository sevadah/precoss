function dx = spm_F1( x, v, pE )
%% loading matrices for Hopfield network
   
    D = 0.2 * diag(ones(1,6));
    
    W = [-0.8881    0.4397    0.2279    0.2280   -0.0147    0.4345;
    0.1931   -0.9626   -0.0836    0.1892    0.3324    0.0405;
    0.4909   -0.1355   -0.7123   -0.5790   -0.0435   -0.5619;
    0.0119    0.0580   -0.6032   -1.0000   -0.2894   -0.0376;
   -0.4133    0.0856   -0.0541   -0.1186   -0.3464    0.1709;
    0.5559    0.1764   -0.3075   -0.0122    0.4482   -0.9253];
    
    % number of syllable
    Ns = length(pE);

    % gamma units - causal states of the level above
    gu = v(1:8,1);
    % syllable units - causal states of the level above
    w = v(10:9+Ns,1); 
    
    % weight spectrotemporal representation of each unit (pE{i}) with its corresponding activation level
    pp = 0;
    for i = 1 : 1 : Ns
        pp = pp + w(i)*pE{i};
    end
    
    % Hopfield network
    kappa1 = 2;
    x1 = x;
    dx1 = kappa1.*(-D*x1 + W*tanh(x1) + pp*gu);

    dx = dx1;

end

