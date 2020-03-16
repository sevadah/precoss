%% calculate Bayes Information Criterion

% number of free parameters per model variant
num_par = [17, 12, 16, 11, 15, 11];

% load approximate log-likelihood
load('log_Like_all.mat')

% calculate BIC based on 210 sentences used for evaluation of model performance
N_sent = 210;

BIC = sum(log_Like_all(11:end,:)) - 0.5*N_sent*log(num_par);