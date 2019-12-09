%% the script calculates syllable number, duration and rate distributions in the original data-set

% getting address
currentFold = pwd;
P1_fold = fileparts(currentFold); 

% address and number of dialects
dataFold = fullfile(P1_fold, 'Data');

full_sentence_list = importdata(fullfile(dataFold, 'full_sentence_list.mat'));
N_sentence = length(full_sentence_list);

syl_dur_dist = [];
syl_number_dist = [];
syl_rate_dist = [];

% for demo, uncomment next line 
% N_sentence = 10
for iSentence = 1 : N_sentence

    curr_sentence = char(full_sentence_list(iSentence));
    sent_data = importdata(fullfile(dataFold, [curr_sentence '.mat']));
    
    syllable_boundaries = sent_data.syllable_boundaries;
    N_syl = length(syllable_boundaries);
    syl_number_dist = [syl_number_dist N_syl];

    sent_dur = syllable_boundaries(2, N_syl) - syllable_boundaries(1,1);
    sent_dur = sent_dur/1000; % convert to seconds from milliseconds

    syl_rate_dist = [syl_rate_dist N_syl/sent_dur];

    % get boundaries in a sentence

    % real boundaries from TIMIT
    startTime = syllable_boundaries(1,:);
    endTime = syllable_boundaries(2,:);
    % boundaries aligned so that the first syllable is the begging of a sentence
    onsets = startTime - startTime(1) + 1;
    offsets = endTime - startTime(1) + 1;

    syllables = offsets - onsets; % syllable durations 

    syl_dur_dist = [syl_dur_dist syllables];
    
end

save('syl_dur_dist', 'syl_dur_dist');
save('syl_number_dist', 'syl_number_dist');
save('syl_rate_dist', 'syl_rate_dist');


