% Let TA pick from the pre-recorded wav file or record your spoken word live:
Fs = 44100; 
nBits = 16; 
nChannels = 2 ; 
ID = -1; % default audio input device 
prompt = 'type 0 (record live), 1 (wav file 1) or 2 (wav file 2) then hit enter => ';
x = input(prompt);
if x == 0
 recObj = audiorecorder(Fs,nBits,nChannels,ID);
 disp('Start speaking.')
 recordblocking(recObj, 2);
 disp('End of Recording.');
 y = getaudiodata(recObj);
 sound(y,Fs);
elseif x == 1
 [y, Fs] = audioread('word1.wav');
 sound(y,Fs);
elseif x == 2
 [y,Fs] = audioread('word2.wav');
 sound(y,Fs);
else
 disp('Error!');
end
% y <= speech sound samples
[One,~] = audioread('word1.wav');% input 'One' Sample
[Two,~] = audioread('word2.wav');% input 'Two' sample

% change to mono-channel
One1 = One(:,1)';
Two1 = Two(:,1)';
y1 = y(:,1)';

%solve the amplitude affect
One1 = One1/max(One1); 
Two1 = Two1/max(Two1);
y1 = y1/max(y1);

%Fast Fourier Transform for "One" and "Two"
%Applying Inverse FFT  
%Get the cross-correlation between the sample and input 
k = length(y1);
yk=fft(y1,2*k);
Onek=fft(One1,2*k);
s1= real(ifft(conj(yk).*Onek)); %imaginary of ifft = 0 so I choose real part of it
s1=[s1(k:2*k) s1(1:k)]; %optional: take half of the samples, just to speed up the program

k = length(y1);
yk=fft(y1,2*k);
Twok=fft(Two1,2*k);
s2= real(ifft(conj(yk).*Twok));
s2=[s2(k:2*k) s2(1:k)]; 

%find the max cross-correlation
s1 = max(s1);
s2 = max(s2);
if(s1>=s2)
    disp("One");
else
    disp("Two");
end
