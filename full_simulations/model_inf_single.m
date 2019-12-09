%% runs inference on all sentences on all model variants
% model variants
N_model = 7; 

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

% choose which model to test
iModel =  1;
% which sentence
% for demo, use iSentence <=5
iSentence = 1;
curr_sentence = char(full_sentence_list(iSentence));

sent_data = importdata(fullfile(dataFold, [curr_sentence '.mat']));
DEM = DoInference(sent_data, iModel);



