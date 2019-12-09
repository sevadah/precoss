%% st_filter_Hyafil:sent_ID, addr
function aud_sptg = get_aud_spectrogram(sent_ID, addr)
% in this case we have the output duration as ms, as well as timing

%% load auditory toolbox - the address should be added to the path beforehand
loadload;

if ~exist('paras', 'var'), paras = [8 8 -2 -1]; end

paras(1) = 1;
paras(2) = 8;
paras(3) = -2;
paras(4) = 0;

% %% addresses
tempFilePath = addr;
N_ch = 6; % number of channels in the reduced spectrogram

D_av = floor(121/N_ch); % 121-th channel roughly corresponds to 5Khz

%% loading audio file and calculating the spectrogram
[x_data, fs] = audioread([tempFilePath '/' sent_ID '.WAV']);
x1 = unitseq(x_data);
y = wav2aud(x1, paras);

tf_full = y';
M = max(max(tf_full));
m = min(min(tf_full));
tf_full_norm = (tf_full - m)/(M-m);
	
for j = 1 : 1 : N_ch-1
    tf_full_norm_av(j, :) = sum(tf_full_norm((j-1)*D_av+1 : j*D_av, :))/D_av;
end
	
tf_full_norm_av(N_ch,:) = sum(tf_full_norm((N_ch-1)*D_av+1 : end, :))/(121-(N_ch-1)*D_av);
	
av_sent(1:N_ch, :) = tf_full_norm_av;

aud_sptg = av_sent;


end
