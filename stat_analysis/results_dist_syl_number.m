%% the script calculates syllable number, duration and rate distributions in the original data-set
colors = [67 126 202; 129 180 246; 246 141 93; 246 187 157; 68 151 135; 126 207 192]/255;
% getting syllable number distribution
load('syl_number_dist.mat')
myFit = fitdist(syl_number_dist', 'kernel');
% plot(4:25, pdf(myFit, 4:25))
% getting performance matrix
load('perf_internal.mat')

N_sentence =  length(syl_number_dist);

[N,edges, nbins] = histcounts(syl_number_dist,10);

% span = 4:2.1:25-2.1
% dist = pdf(myFit, span);
dist = N/max(N);
span = 4 :2.33 : 25;
% span = 25 :2.33 : 4;
figure; hold on
% b = bar(span, dist, 'FaceColor',[235 233 237]/255,'EdgeColor',[.1 .1 .1])
b = bar(span, fliplr(dist), 'FaceColor',[235 233 237]/255,'EdgeColor',[.1 .1 .1])
% hist(syl_number_dist/50,10)

for iModel = 1:6
    perf = perf_internal(:,iModel);
    for i = 1 : length(N)
        result = find(nbins==i);
        av_perf(i) = median(perf(result));
        clear result
    end
%     h = plot(span, av_perf/max(av_perf))
    h = plot(span, fliplr(av_perf/max(av_perf)))
    set(h, {'color'}, {colors(iModel,:)});
end


% iModel = 1
% perf = perf_internal(:,iModel);
% for i = 1 : length(N)
%     result = find(nbins==i);
%     av_perf(i) = mean(perf(result));
%     clear result
% end
% plot(span, av_perf/max(av_perf))
    
% xticklable_names = {'4-6'; '7-8'; '9-10'; '11-12'; ...
%     '13-14'; '15-16'; '17-18'; '19-20'; '21-22'; '23-25'};
% set(gca,'xticklabel',xticklable_names)

xticklable_names = num2str(fliplr(floor(span))')
% set(gca,'xticklabel',xticklable_names)
% xticks = fliplr(span)
xticklables = {num2str(fliplr(span)')};
xlabel('number of syllables')
ylabel('power (a.u.)')
legend('', 'A', 'B', 'C', 'D', 'E', 'F')
% colors = [67 126 202; 129 180 246; 246 141 93; 246 187 157; 68 151 135; 126 207 192]/255;