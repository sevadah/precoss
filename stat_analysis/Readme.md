# Readme
Scripts are devided for models with theta or without theta (+explicit reset).
in below scripts replace _{tag} either with {tag} = `theta`, `notheta`, `explicit`.

Scripts `perf_eval_{tag}` and `perf_eval_compressed_{tag}` evaluate the performance of each model variant for the normal and compressed speech data respectively.

Function `perf_duration_overlap.m` calculate the performance for a single sentence defined in the function parameter based on internally signalled temporal window. 

`stat_analysis.m` performs Wilcoxon signed-ranked test for each model variant pair and controls for multiple comparisons with the Bonferroni procedure.

`compressed_analysis.m` performs paired ttest for each compression factor tested.

`EstimateChanceLevel` calculates the chance level based on simulations that mimics model's recognition by randomly selecting duration and identify of "recognized" syllables in a sentence.

Files `syl_dur_dist.mat`, `syl_number_dist.mat` and `syl_rate_dist.mat` contain the source data for the distributions presented in Figure 2.

File named `perf_internal.mat` contains simulations results for all 220 sentences based on the temporal windows signalled internally and associated with the gamma sequence. Source data of figures 3 and 6 are included in `perf_internal.mat`, the first 10 raws are discarded. 

File named `perf_results_compression.mat` contains simulations results for the compressed speech  and source data for Figure 4 (again the first 10 raws are discarded).


