%% st_filter_Hyafil:sent_ID, addr
function [slow_amod, syllable_boundaries, onset_trigger] = sent_data_gen(sent_ID, addr)
% in this case we have the output duration as ms, as well as timing

%% load auditory toolbox - the address should be added to the path beforehand
loadload;

if ~exist('paras', 'var'), paras = [8 8 -2 -1]; end

paras(1) = 1;
paras(2) = 8;
paras(3) = -2;
paras(4) = 0;

%% addresses
tempFilePath = addr;

%% parameters used in Hyafil
nchan = 32;
input_gain = 0.3333;
dt = 0.1;
load('sta_chan.mat');
Ichannel2D = sta_chan;
Dconv = load('conv1000.mat');

%% loading audio file and calculating the spectrogram
[x_data, fs] = audioread([tempFilePath '/' sent_ID '.WAV']);
x1 = unitseq(x_data);
y = wav2aud(x1, paras);
tf_full = y';

%% calculate syllable boundaries - original one from tsylab
sylbTcell = importdata([tempFilePath '/' sent_ID '.sylbtime']);
N_syl = length(sylbTcell);
st_start = zeros(N_syl,1);
st_end = zeros(N_syl,1);

for j = 1 : 1 : N_syl
    tmp = strsplit(sylbTcell{j}, '\t');
    st_start(j) = str2double(tmp{1}); %samples
    st_end(j) = str2double(tmp{2}); % samples
    
    st_start(j) = floor(st_start(j)/(fs/1000)); %ms
    st_end(j) = floor(st_end(j)/(fs/1000)); % ms
end
%% calculating the filtered output
% as in original scripts

whichchanH = (1:nchan)*floor(128/nchan);
whichchanL = whichchanH -3;

% the following couple of line are a bit confusing
% seems it was added to account for a signal with different sampling frequency
fe = 1000;
chan = input_gain*(tf_full/4);

stidur = ceil(size(chan,2)/(fe/1000)/dt)*dt;
TTchan = stidur*(fe/1000); % ???

for iE=1:nchan
    chaninput_tmp(iE,:) = Ichannel2D(iE)*mean(chan(whichchanL(iE):whichchanH(iE), 1:TTchan),1);
end
chaninput=sum(chaninput_tmp,1); % chaninput_tmp is what goes to gamma I believe

% now it convolves with the spectortemporal filter to get input to theta

chaninput1 = smoothdownsample(chaninput, fe/Dconv.fe);
chaninput2 = filter(Dconv.Dconv, [1 zeros(1,length(Dconv.Dconv)-1)], chaninput1);
chaninput3 = chaninput2(ceil(Dconv.fe/fe:Dconv.fe/fe:length(chaninput2)));

% getting the smooth versions
lenX = length(chaninput2);
newL = length(downsample(x_data,fs/1000));
v = 1 : 1 : lenX;
vq = lenX/newL : lenX/newL : lenX;

chaninput4 = interp1(v, chaninput2, vq);

L = min(length(chaninput4), length(chaninput3));
%% results

input_smooth = chaninput4(1:L);
input_smooth = smooth(input_smooth',10)';

%% original
syllable_boundaries(1,:) = st_start;
syllable_boundaries(2,:) = st_end;

sigma = 1.5;
t = 1 : 1 : L;
trg_orig = 0;
for j = 1 : length(st_start)
	myu = st_start(j);
	tempTr = sigma*sqrt(2*pi)*normpdf(t,myu,sigma);
	trg_orig = trg_orig + tempTr;
end

onset_trigger = trg_orig;
slow_amod = input_smooth;
end
