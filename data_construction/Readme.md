# Readme

Scripts in here are used to pre-process sound waveforms from the TIMIT database for model simulations. All sentences in the `TRAIN` sub-folder in TIMIT dataset corresponding to the dialect 8 (`DR8`) were used. Firstly all sentences of each speaker were moved to a specific subdirectory with the sentence ID in the name. 

For example: `/DR8/MBCG0/SA1` directory contains files for the sentence `SA1` of the speaker `MBCG0` from dialect `DR8`: which are:

* `SA1.WAV` -> the sound recording
* `SA1.WRD` -> words (and their boundaries in samples) of the sentence in the recording
* `SA1.sylbtime` -> output of the Tsylb2 software that signals syllable boundaries based on the phonemic transcription (not included in example dataset) and English grammar rules.

The script `gen_and_save_sentence_data.m` generates processed data for each sentence in the current directory that are in `DR_{N}` named folder (in this case it is N=8) and saves the resulting data in the folder specified in `dataFold`.

For each sentence, the data is stored in a `.mat` file named as follows `{dialect_ID}_{speaker_ID}_{sentence_ID}`, for the above example that would be `DR8_MBCG0_SA1.mat`.

Finally, it also stores the `.mat` named `full_sentence_list.mat`, where the list of all sentences (names as described in the previous step) are included.

The `NSLtools-master` toolbox from Chi and Shamma 2005 should be added into the Matlab path.

`conv1000.mat`, `sta_chan.mat`, `smoothdownsample.m` and most part of the `sent_data_gen.m` are taken from Hyafil et al. (2005), eLife paper.