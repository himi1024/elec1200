% Pre-record your words and save into wav files:
Fs = 44100; 
nBits = 16; 
nChannels = 2 ; 
ID = -1; % default audio input device 
 recObj = audiorecorder(Fs,nBits,nChannels,ID);
 disp('Start speaking.')
 recordblocking(recObj, 2);
 disp('End of Recording.');
 y = getaudiodata(recObj);
 filename = 'word2.wav'; % use word2.wav for the second word
 audiowrite(filename,y,Fs);
 % load your wav file 
 [x, Fs] = audioread('word2.wav'); % change to word2.wav for the second word
 sound(x,Fs); % playback your pre-recorded sound
