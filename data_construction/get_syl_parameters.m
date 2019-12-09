function P_all = get_syl_parameters(sentence, syllable_boundaries)
% gives as an output parameters of syllables of a sentence

A = 0.2 * diag(ones(1,6));

W = [-0.8881    0.4397    0.2279    0.2280   -0.0147    0.4345;
    0.1931   -0.9626   -0.0836    0.1892    0.3324    0.0405;
    0.4909   -0.1355   -0.7123   -0.5790   -0.0435   -0.5619;
    0.0119    0.0580   -0.6032   -1.0000   -0.2894   -0.0376;
   -0.4133    0.0856   -0.0541   -0.1186   -0.3464    0.1709;
    0.5559    0.1764   -0.3075   -0.0122    0.4482   -0.9253];
    
P_all = {};

N_ch = 6; % number of frequency channels
N_g = 8; % number of gamma units
N_syl = length(syllable_boundaries); % number of syllable units

for iSyl = 1 : N_syl

	% onset and offset of a current syllable
	syl_start = syllable_boundaries(1,iSyl);
	syl_end = syllable_boundaries(2,iSyl);

	% getting syllables spectro-temporal patterns
	syllable = sentence(:, syl_start : syl_end);
	% syllable duration
	L = length(syllable);
	% 1/N_g -th duration
	delta = floor(L/N_g);

	Ix = zeros(N_ch, N_g); % average value of each freq channel for delta interval
	for iG = 1 : N_g-1
		Ix(:, iG) = mean(syllable(:, (iG-1)*delta + 1 : iG*delta)')';
	end
	Ix(:, N_g) = mean(syllable(:, (N_g-1)*delta + 1 : end)')';

	P_all{iSyl} = A*Ix - W*tanh(Ix);

	clear Ix syllable delta
end

silent_unit = zeros(N_ch,N_g);

P_all{N_syl+1} = silent_unit;

end
