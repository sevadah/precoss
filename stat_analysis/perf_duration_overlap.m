function [r, idx_g1] = perf_duration_overlap(su, g1, startT, endT)
	int_perf_curve = zeros(1, length(su)); % duration and identity of recognized syllable
	real_perf_curve = zeros(1, length(su)); % duration and identity of syllable in the input
	% curves, should be "curves", look like stairs
	% (for the syllable N1 the amplitude would be 1, for the syllable N10, the amplitude would be 10)
	iG_idx = []; % to store the sequence of recognized syllables
	for iG = 1 : length(g1)-1
		st = g1(iG);
		en = g1(iG+1);
		temp_syl_dyn = su(st:en, :);

		[val idx] = max(sum(temp_syl_dyn));
        if st < endT(end)
            iG_idx = [iG_idx idx];
        end

		int_perf_curve(st:en) = idx;
		clear st en temp_syl_dyn
	end

	for iSyl = 1 : length(startT)
        st = startT(iSyl);
        en = endT(iSyl);

        real_perf_curve(st:en) = iSyl;
        clear st en temp_syl_dyn
    end

	dd = real_perf_curve - int_perf_curve; % comparing "curves" 
	% (whenever the selected syllable corresponds to the syllable in the input, dd would be 0)

	d1 = dd(1:endT(end)); % taking the info until the end of sentence
	d1(abs(d1)>0) = []; % removing the ones that do not overlap (dd != 0)

	r = length(d1)/endT(end); % estimate of the performance, the closer to 1 the better
	idx_g1 = iG_idx; % sequence of recognized syllables 
end