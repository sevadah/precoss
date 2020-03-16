%% description
% calculates the approximate log-likelihood for each model m

% model variants
N_model = 6;

% variant 1-6 as in manuscript
% variant 7-9, variant B, D, F with removed units
% data folders
dataFolderName = {'variant_1', 'variant_2', 'variant_3', ...
    'variant_4', 'variant_5', 'variant_6'};

%% getting address
currentFold = pwd;
P1_fold = fileparts(currentFold); % now we are on the folder corresponding model type

% address and number of dialects
dataFold = fullfile(P1_fold, 'Data');

full_sentence_list = importdata(fullfile(dataFold, 'full_sentence_list.mat'));
N_sentence = length(full_sentence_list);

log_Like_all = zeros(N_sentence, N_model);
whichModels = [1 7 3 8 5 9];
NwhichModels = length(whichModels);

for iModel = 1 : N_model
    fpath = fullfile(dataFold, dataFolderName{iModel});
    
    for iSentence = 1 : N_sentence
        
        curr_sentence = char(full_sentence_list(iSentence));
        % get sentence data
        sent_data = importdata(fullfile(dataFold, [curr_sentence '.mat'])); % getting sentence data
        N_syl = length(sent_data.P_all);
        
        
        DEM = importdata(fullfile(fpath, ['DEM_' curr_sentence '.mat']));
        
        [syllables, real_input] = get_y_syllables(DEM, sent_data);

        % number of non_syllable causal states
        Nr = 8; % for models without theta module
        if mod(iModel,2) > 0
            Nr = 9; %for models with theta module
        end
%         size(syllables)
        log_like = get_logLike(syllables, real_input, Nr, DEM, sent_data);

        log_Like_all(iSentence, iModel) = log_like;
        clear cov_vv sent_data DEM curr_sentence syllables
        clear real_input post_prob
    end
    
end

% save('aic_all_mat_nova', 'aic_all_mat')
% save('bic_all_mat_nova', 'bic_all_mat')
save('log_Like_all', 'log_Like_all')
