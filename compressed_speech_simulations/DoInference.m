function rDEM = DoInference(sent_data, iModel )
% number of frequency channels
N1 = 6;

% number of gamma units
N2 = 8;


I = sent_data.P_all; % load syllable parameters - stored spectrotemporal patterns
Y0 = sent_data.aud_sptg; % load frequency channel dynamics
syllable_boundaries = sent_data.syllable_boundaries; % syllable boundaries
Y = Y0(:, syllable_boundaries(1,1) : end);
Nsyl = length(I);

%% setting precisions
% level 1
% precision for the hidden states
Wh1(1:N1, 1) = exp(15); % time-frequency decomp. / spectral content
% causal states
Vh1(1:N1,1) = exp(10);  % time-frequency decomp. / spectral content
% level 2
% hidden states
Wh2(1 : 2*N2, 1) = exp(5); % gamma units
Wh2(2*N2 + 1,  1) = exp(5); % preferred gamma sequence duration/speed

Wh2(2*N2 + 2 : 2*N2+Nsyl+1,  1) = exp(3); % syllable unit
Wh2(end,1) = exp(1); % silent unit has lower precision

% causal states
Vh2(1 : N2, 1) = exp(1.5); % gamma units

Vh2(N2+1 : N2+Nsyl,1) = exp(5); % syllable units

%% for the preferred speed
if iModel == 2
	Y = compress_signal(Y, 2);
    generative_model_inf_v2;
elseif iModel == 4
	Y = compress_signal(Y, 3);
    generative_model_inf_v2;
end

DEM.Y = Y;
DEM.M = M;

DEM = spm_DEM(DEM);
close all
%% getting the output
rDEM = DEM;
end

