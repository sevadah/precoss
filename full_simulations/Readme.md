# Readme

## Content

The folder contains the scripts to run model simulations for all model variants presented in the manuscript.

## Initiate the generative model

Scripts names `generative_model_inf_v{1}.m`, where {i = 1 : 7} (for each model variant presented in the table below) are used to initiate the generative model. In there functions called `spm_F1`, `spm_F2_v{i}` and `spm_G1`, `spm_G2` correspond to the hidden and causal states for each model level. 

## Run Simulations

The master script (the one that starts simulations for all models) is called `model_inf_all_par.m`. It uses parallel computing toolbox in Matlab (`parfor` is used). If you like to run a simulation for a single sentence, you may run the  `model_inf_single.m` script, where you also set which model (`iModel`) you are running on which sentence (`iSentence`). 

`iModel` corresponds to the model variants (from 1 to 7, see the table below).

`iSentence` corresponds to sentence variants (from 1 : 220, the total number of sentences).

> 5 processed sentences (first 5 in the list) were uploaded. Preprocessing steps and original data described in the corresponding section.

`full_sentence_list` contains all sentences preprocessed for the model

> preprocessing meaning to transform sound waveform to 6-channel auditory spectrogram and 1 channel signal for slow amplitude modulation
> see `data_construction` folder for details

Finally, the script `DoInference.m` is the actual script running simulations, it is also the place where we set precisions for each variable of hidden and causal states. The script is called from the `model_inf_all_par.m` or `model_inf_single.m`.

| model number | model variant | description |
| :----------- | :------------ | :----------------------------------------------------------- |
| 1 | A | exogenous theta-gamma coupling, theta resets gamma, syllable units reset |
| 2 | B | endogenous theta-gamma coupling, no gamma reset, syllable units reset |
| 3 | C | no theta-gamma coupling, theta resets gamma, syllable units reset |
| 4 | D | no theta-gamma coupling, no gamma reset, syllable units reset |
| 5 | E | no theta-gamma coupling, theta resets gamma, no syllable units reset |
| 6 | F | no theta-gamma coupling, no gamma reset, no syllable units reset |
| 7 | A' | endogenous theta-gamma coupling, explicit onsets reset gamma, syllable units reset |




----

To run simulations `spm_12` package is needed. https://www.fil.ion.ucl.ac.uk/spm/software/spm12/ 

A version from 2014 was used for simulations. 
The package should be added to the Matlab path.