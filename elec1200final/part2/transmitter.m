load txtext.mat
tx_bs = text2bitseq(textmsg);
%framing
tx_bs = [1 tx_bs 0];
SPB = 49;


tx_bs1 = [tx_bs zeros(1, 4002-length(tx_bs))];

tx_wave = bitseq2waveform(tx_bs1, SPB);

tx_wave = add_training(tx_wave);

rx_wave = txrx(tx_wave);