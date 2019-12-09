% load simulation results
load('perf_results_compression.mat'); 
% column 1 - > variant A compression factor 2
% column 2 - > variant B compression factor 2
% column 3 - > variant A compression factor 3
% column 4 - > variant B compression factor 3 

perf = 100*perf_internal; % convert to percentages
% discard the first 10 sentences
perf = perf(11:end,:);

%% one tailed paired ttest
display ('compression x2')
[h,p,ci,stats] = ttest(perf(:,1) , perf(:, 2), 'Tail','right')

display ('compression x3')
[h,p,ci,stats] = ttest(perf(:,3) , perf(:, 4), 'Tail','right')

