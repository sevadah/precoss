function logLike = get_logLike(syllables, real_input, Nr, DEM, sent_data)
    
    % getting real input
    syllable_boundaries = sent_data.syllable_boundaries;
    startTime = syllable_boundaries(1,:);
    endTime = syllable_boundaries(2,:);
    
    % re align so the first syllable onset is the start of the sentence 
    % (in TIMIT there is initial 0-padding)
    startT = startTime - startTime(1) + 1;
    endT = endTime - startTime(1) + 1;
    
    CC  = DEM.qU.C; % causal states covariances matrices
    
    % number of syllables (excluding the silent one)
    Ns = size(syllables,1);
    Nr = Nr+1; % inludes the silent term
    
    logLike = 0;
    for iSyl = 1 : Ns
        int_post = 0;
        for i = startT(iSyl) : endT(iSyl)
            % getting covariance matrix
            R = full(CC{i});
            D = reArrangeMat(R, Nr-1); % so the last silent unit is next before the syllable units
            % cov_mat Ns
            B = D(1:Nr, 1:Nr); % Nr x Nr suqare matrix

            % cov_mat Syllables
            A = D(Nr+1 : end, Nr+1 : end); % Ns x Ns
    %         size(A)

            % cov_mat of interaction / off diagonal
            C = D(Nr+1: end, 1 : Nr);
            % compo mats
            Acom = A - C*(B^-1)*C';
            dS = syllables(:,i) - real_input(:,i);

            gauss_coef = dS'*Acom*dS;

            %% full gaus_coef
            norm_coef = power(2*pi, -Ns/2)*power(det(D), 0.5)*power(det(B), -0.5);

            gauss_term = norm_coef*exp(-0.5*gauss_coef);
            int_post = int_post + log(gauss_term);
            
            clear A B C D dG dS gauss_coef_int gauss_term R 
        end
        logLike = logLike + int_post/(endT(iSyl) - startT(iSyl)); % add average across syllable duration
    end


end
