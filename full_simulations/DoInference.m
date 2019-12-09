function rDEM = DoInference(sent_data, iModel )
% number of frequency channels
N1 = 6;

% number of gamma units
N2 = 8;


I = sent_data.P_all; % load syllable parameters - stored spectrotemporal patterns
E0 = sent_data.slow_amod; % load slow amplitude modulation
Y0 = sent_data.aud_sptg; % load frequency channel dynamics
syllable_boundaries = sent_data.syllable_boundaries; % syllable boundaries


Y0(7, 1:end) = E0;
Y = Y0(:, syllable_boundaries(1,1) : end);
clear Y0 E0
Nsyl = length(I);
%% setting precisions
% level 1
% precision for the hidden states
Wh1(1:N1, 1) = exp(15); % time-frequency decomp. / spectral content
% causal states
Vh1(1:N1,1) = exp(10);  % time-frequency decomp. / spectral content
Vh1(N1+1,1) = exp(10);  % slow amplitude modulation / input
% level 2
% hidden states
Wh2(1 : 2*N2, 1) = exp(5); % gamma units
Wh2(2*N2 + 1,  1) = exp(5); % preferred gamma sequence duration/speed
Wh2(2*N2 + 2,  1) = exp(7); % theta
Wh2(2*N2 + 3,  1) = exp(7); % theta

Wh2(2*N2 + 4,  1) = exp(15); % slow amplitude modulation / input

Wh2(2*N2 + 5 : 2*N2+Nsyl+4,  1) = exp(3); % syllable unit
Wh2(end,1) = exp(1); % silent unit has lower precision

% causal states
Vh2(1 : N2, 1) = exp(1.5); % gamma units
Vh2(N2+1, 1) = exp(7); % slow amplitude modulation / input

Vh2(N2+2 : N2+Nsyl+1,1) = exp(5); % syllable units


if iModel == 1
    generative_model_inf_v1;
elseif iModel == 2
    generative_model_inf_v2;
elseif iModel == 3
    generative_model_inf_v3;
elseif iModel == 4
    generative_model_inf_v4;
elseif iModel == 5
    generative_model_inf_v5;
elseif iModel == 6
    generative_model_inf_v6;
elseif iModel == 7
    % level 3
    Vh3 = exp(25);

    generative_model_inf_v7;
    U = sent_data.onset_trigger;
    DEM.U = U(syllable_boundaries(1,1) : end);
end

DEM.Y = Y;
DEM.M = M;

DEM = spm_DEM(DEM);
close all
%% getting the output
rDEM = DEM;
end

