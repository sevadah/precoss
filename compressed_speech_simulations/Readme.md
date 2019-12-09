# Readme

Scripts for the simulations with compressed speech, relate to figure 4.

Only 2 model variants were tested with compressed speech:

* variant A, with exogenous theta oscillations that signals to the gamma units the syllable onset information and theta frequency rate information, which is used to set the preferred gamma rate and indirectly gamma sequence duration.
* variant B, where we used endogenous theta-gamma coupling, which appears when we set internally fixed, preferred gamma rate. There is no explicit onset information provided to the gamma sequence.

Furthermore: each model variant was tested with the speech signal compressed by a factor of x2 and x3. 

as for the main simulations, the script `model_inf_all_par.m` starts the inference for each model and sentences specified in the variables `iModel`, `iSentence`, `full_sentence_list`.

One additional script `compress_signal.m` was added for this case that compresses the signal with the given compression factor.