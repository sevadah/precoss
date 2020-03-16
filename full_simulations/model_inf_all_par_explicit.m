%% runs inference on all sentences on all model variants
% model variants
% variant A' - > preferred gamma rate (internally set) = endogenous theta - gamma coupling, SU reset, gamma reset by explicit onsets

%% getting address
currentFold = pwd;
P1_fold = fileparts(currentFold); % now we are on the folder corresponding model type

% address and number of dialects
dataFold = fullfile(P1_fold, 'Data');

full_sentence_list = importdata(fullfile(dataFold, 'full_sentence_list.mat'));
N_sentence = length(full_sentence_list);

% for demo, use N_sentence <=5
N_sentence = 5;

% creating folders for each model variant

fpath = fullfile(dataFold, 'explicit_resets');
if exist(fpath, 'dir') ~= 7
    mkdir(fpath);
end 

parfor iSentence = 1 : N_sentence

    curr_sentence = char(full_sentence_list(iSentence));
    
    sent_data = importdata(fullfile(dataFold, [curr_sentence '.mat']));
    DEM = DoInference_explicit(sent_data, iModel);
    
    fname = ['DEM_' curr_sentence];
    parsave(fullfile(fpath, fname), DEM)
   
end


delete(gcp('nocreate'))
