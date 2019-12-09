currentFold = fullfile(pwd);
P1_fold = fileparts(currentFold); % now we are on the folder corresponding model type
dataFold = fullfile(P1_fold, 'Data');

dir_content = dir(currentFold);
dir_flags = [dir_content.isdir];
sub_folders = dir_content(dir_flags); % this included ./git and all hidden folders whose names start with .
% e.g. by default in Matlab there are folders '.', '..'
% adjust by convenience, e.g. if there is git folder or not

dialect_list = sub_folders(startsWith({sub_folders.name}, "DR"));
dialects = {dialect_list.name};

save('dialects', 'dialects');

clear dialect_list sub_folders dir_flags dir_content
full_sent_name = {};

N_dialect = length(dialects);
sent_counter = 0;
for iD = 1 : N_dialect
	DR = char(dialects(iD));
	DR_address = fullfile(currentFold, DR);

	dir_content = dir(DR_address);
	dir_flags = [dir_content.isdir];
	sub_folders = dir_content(dir_flags);

	dot_foldList = startsWith({sub_folders.name}, ".");
	sub_folders(dot_foldList) = [];

	speaker_ID = {sub_folders.name};
	fname = 'speaker_ID';
	save(fullfile(DR_address, fname), 'speaker_ID');

	clear dot_foldlist sub_folders dir_flags dir_content fname

	for iSpeaker = 1 : length(speaker_ID)

		curr_speaker = char(speaker_ID(iSpeaker));
		speaker_address = fullfile(DR_address, curr_speaker);

		dir_content = dir(speaker_address);
		dir_flags = [dir_content.isdir];
		sub_folders = dir_content(dir_flags);

		dot_foldList = startsWith({sub_folders.name}, ".");
		sub_folders(dot_foldList) = [];

		sent_ID = {sub_folders.name};

		fname = 'sent_ID';
		save(fullfile(speaker_address, fname), 'sent_ID');

		clear dot_foldlist sub_folders dir_flags dir_content fname

		for iSentence = 1 : length(sent_ID)
			sent_counter = sent_counter + 1;
			curr_sentence = char(sent_ID(iSentence));
			sentence_address = fullfile(speaker_address, curr_sentence);

			% getting amplitude modulation, boundaries and onsets
			[slow_amod, syllable_boundaries, onset_trigger] = sent_data_gen(curr_sentence, sentence_address);

			% getting 6-channel auditory spectorgram
			aud_sptg = get_aud_spectrogram(curr_sentence, sentence_address);

			% getting parameters 
			P_all = get_syl_parameters(aud_sptg, syllable_boundaries);

			fname = [curr_sentence '_data'];
			full_fname = [DR '_' curr_speaker '_' curr_sentence];
			% fpath = fullfile(dataFold,full_fname);
			fpath = dataFold;
			% if exist(fpath, 'dir') ~= 7
         	%	mkdir(fpath);
     		% end	
            save(fullfile(fpath, full_fname), 'slow_amod', 'syllable_boundaries', 'onset_trigger', ...
                'aud_sptg', 'P_all');
            full_sent_name{sent_counter} = full_fname;
            clear curr_sentence sentence_address slow_amod syllable_boundaries onset_trigger
            clear aud_sptg P_all fname
            clear full_fname fpath
		end

	end

end

fname = 'full_sentence_list';
fpath = dataFold;

full_sentence_list = full_sent_name;
save(fullfile(fpath, fname), 'full_sentence_list');
