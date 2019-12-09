%% statistical analysis for Figures 3 and 5

% get performance
perf_all = importdata('perf_internal.mat'); 

% discard the first 10 sentences
perf_all = perf_all(11:end,:);

%% analysis for Figure 3 - theta vs no onset information
% performs pairwise comparisons for each pair
% controls for multiple comparisons with Bonferroni procedure
perf = perf_all;
perf(:, [7]) = []; % discard the column corresponding to A'

[L N] = size(perf);

p_pairs = zeros(N*(N-1)/2,1);
k = 0;
for i = 1 : N
    for j = i+1 : N
        k = k +1;
        [p h] = signrank(perf(:,i) , perf(:, j));
        p_pairs(k,1) =  p;
        h_pairs(k,1) =  h;
    end
end

alpha_orig = 1e-7;
h_f3 = p_pairs < alpha_orig/length(p_pairs);


%% analysis for Figure 5 - theta vs explicit onset
% remove columns for the other model variants and keep only for A and A`
% 1st column corresponds to A
% 2nd column corresponds to A'
perf = perf_all;
perf(:, [2:6]) = []; 

% paired ttest - 2tailed
[h,p,ci,stats] = ttest(perf(:,1) , perf(:, 2))

