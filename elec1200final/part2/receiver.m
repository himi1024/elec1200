clc;
clear;
load rxwave.mat;

SPB = 49;
%c,k,T
%c = min(rx_wave);
%k = max(rx_wave);
%T = c+k/2;
T = get_threshold(rx_wave);

%delay
%d=1;
%while rx_wave(d) < c+0.2
%    d=d+1;
%end
d = find_start(rx_wave);

%waveform2bitseqwaveform
for i = 1: length(rx_wave)
    if rx_wave(i) >= T
        rx_wave(i) = 1;
    else 
        rx_wave(i) = 0;
    end
end


rx_bs = zeros(1, 4000);

for k = 1:4000
    if(k*SPB < 200000)
        rx_bs(k) = rx_wave(d+(k+1)*SPB-30);
    end
end

rx_msg = char(bitseq2text(rx_bs));

compute_BER(rx_bs, rx_msg);


    