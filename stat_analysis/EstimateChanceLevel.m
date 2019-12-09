%% chance level based on internal timing
% getting address
currentFold = pwd;
P1_fold = fileparts(currentFold); 

% address and number of dialects
dataFold = fullfile(P1_fold, 'Data');

full_sentence_list = importdata(fullfile(dataFold, 'full_sentence_list.mat'));
N_sentence = length(full_sentence_list);

%% load syllable number and duration distributions
syl_duration = importdata('syl_dur_dist.mat');
tot_dur_N =  length(syl_duration);
syl_number = importdata('syl_number_dist.mat');
tot_syl_N =  length(syl_number);

%% simulations to estimate the chance level
ch = []; % variable were results are stored

% for demo, uncomment next line 
N_sentence = 10

for i = 1 : 1000
    for iSentence = 1 : N_sentence
        curr_sentence = char(full_sentence_list(iSentence));
        sent_data = importdata(fullfile(dataFold, [curr_sentence '.mat']));
        syllable_boundaries = sent_data.syllable_boundaries;
        
        % real boundaries from TIMIT
        startTime = syllable_boundaries(1,:);
        endTime = syllable_boundaries(2,:);
        % boundaries aligned so that the first syllable is the begging of a sentence
        onsets = startTime - startTime(1) + 1;
        offsets = endTime - startTime(1) + 1;
        
        N_syl = length(onsets); % syllable number
        syllables = offsets - onsets; % syllable durations 
        
        % random original sentence
        orig_sentence = [];
        length(orig_sentence);
        
        for j = 1 : N_syl
            temp = ones(1,syllables(j))*j; % duration of a current syllable
            orig_sentence = [orig_sentence temp];  
        end
        
        % random recognition
        % number of syllables is the same
        % we select a random duration from the syllable duration distribution
        % and identity of the syllable by randomly selecting one from the syllables
        % of the current sentence
        % the procedure repeats until "random" sentence reaches the duration of the current sentence
        % for each sentence we repeat the sentence for 1000 times and select the mean
        rand_rec_sentence = [];
        for j = 1 : 1000
            while length(rand_rec_sentence) < sum(syllables)
                rand_syl_dur = syl_duration(randi([1 tot_dur_N],1,1));
                temp = ones(1,rand_syl_dur)*randi([1 N_syl],1,1);
                
                rand_rec_sentence = [rand_rec_sentence temp];
            end
            rand_rec_sentence = rand_rec_sentence(1:sum(syllables));
            
            % calculate performance value
            d = abs(orig_sentence - rand_rec_sentence);
            d(d>0) = []; % check when there is no overlap, so recognition was not correct and delete it
            % remaining duration would correspond to the correct identification
            q(j) = length(d)/sum(syllables);
        end
        
        p(iSentence) = mean(q); % stor the mean value after 1000 simulations for a sentence
        clear q
    end
    ch = [ch p]; % keep results for whole dataset
end

chance_level = median(ch);

