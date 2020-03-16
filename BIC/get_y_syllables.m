function [syllables, real_input] = get_y_syllables(DEM, sent_data)
% getting real input
syllable_boundaries = sent_data.syllable_boundaries;
startTime = syllable_boundaries(1,:);
endTime = syllable_boundaries(2,:);

% re align so the first syllable onset is the start of the sentence 
% (in TIMIT there is initial 0-padding)
startT = startTime - startTime(1) + 1;
endT = endTime - startTime(1) + 1;

N_syl = length(startT); % without silent


% get causal states of level 2
vv2 = full(DEM.qU.v{2})';

% get dynamics of causal states of the syllable
Nv = size(vv2,2);
v_range = (Nv - N_syl) : Nv - 1;
syllables = vv2(:, v_range); % without the silent unit

real_input=zeros(N_syl, length(syllables)); % includes silent unit

for iSyl = 1 : length(startT)
    st = startT(iSyl);
    en = endT(iSyl);

    real_input(iSyl, st:en) = 1;
    clear st en temp_syl_dyn
end
syllables = syllables';




end
