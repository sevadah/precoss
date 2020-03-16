%% runs inference on all sentences on all model variants
% model variants
N_model = 6; 

% variant A  - > preferred gamma rate by theta = exogenous theta - gamma coupling, SU reset, gamma reset by theta
% variant B  - > preferred gamma rate (internally set) = endogenous theta - gamma coupling, SU reset, no gamma reset by theta
% variant C  - > no preferred gamma rate = no theta-gamma coupling, SU reset, gamma reset by theta
% variant D  - > no preferred gamma rate = no theta-gamma coupling, SU reset, no gamma reset by theta
% variant E  - > no preferred gamma rate = no theta-gamma coupling, no SU reset, gamma reset by theta
% variant F  - > no preferred gamma rate = no theta-gamma coupling, no SU reset, no gamma reset by theta
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
for iModel =  1 : 2 : N_model
    fpath = fullfile(dataFold, ['variant_' num2str(iModel)]);
    if exist(fpath, 'dir') ~= 7
        mkdir(fpath);
    end 

    parfor iSentence = 1 : N_sentence

        curr_sentence = char(full_sentence_list(iSentence))
        
        sent_data = importdata(fullfile(dataFold, [curr_sentence '.mat']));
        DEM = DoInference_theta(sent_data, iModel);
        
        fname = ['DEM_' curr_sentence];
        parsave(fullfile(fpath, fname), DEM)
       
    end

end

delete(gcp('nocreate'))
