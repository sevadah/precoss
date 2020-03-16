function rDEM = DoInference_theta(sent_data, iModel )
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
Vh1(1:N1,1) = exp(10);  % time-frequency decomp. / spectral content
Vh1(N1+1,1) = exp(10);  % slow amplitude modulation / input
% level 2
Wh2(1 : 2*N2, 1) = exp(5); % gamma units
Wh2(2*N2 + 1,  1) = exp(5); % gamma_speed
Wh2(2*N2 + 2,  1) = exp(7); % theta
Wh2(2*N2 + 3,  1) = exp(7); % theta

Wh2(2*N2 + 4,  1) = exp(15); % slow amplitude modulation / input

Wh2(2*N2 + 5 : 2*N2+Nsyl+4,  1) = exp(3); % syllable unit
Wh2(end,1) = exp(1); % silent unit has lower precision

Vh2(1 : N2, 1) = exp(1.5); % timing units
Vh2(N2+1, 1) = exp(7); % slow amplitude modulation / input

Vh2(N2+2 : N2+Nsyl+1,1) = exp(5); % syllable units

%% for the preferred speed
if iModel == 1
	Y = compress_signal(Y, 2);
    generative_model_inf_v1;
elseif iModel == 3
	Y = compress_signal(Y, 3);
    generative_model_inf_v1;
end


DEM.Y = Y;
DEM.M = M;

DEM = spm_DEM(DEM);
close all
%% getting the output
rDEM = DEM;
end
