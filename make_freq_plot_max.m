function [max_amp,max_freq,zero_amp]  = make_freq_plot_max(x, Fs)

% Calcuate max amplitude (which represent acceleration in m/s2)
% and the corresponding dominant non-zero frequency(Hz), and find the
% amplitude of 0Hz frequency.
%   Args:
%   x = input signal
%   Fs = sampling frequency (Hz)
%   Outputs: 
%   max_amp = acceleration of dominate non-zero frequency (m/s2)
%   max_freq = dominate frequency (Hz)

% make number of data samples even
if(mod(length(x),2) ~=0)
    x = x(1:end-1);
end

% frequency domain
freq_domain = linspace(-Fs/2, Fs/2-Fs/length(x),length(x));

% plot signal over frequency domain
plot(freq_domain, 1/length(x)*fftshift(abs(fft(x))))
title("data in frequency domain")
ylabel('Magnitude of signal');
xlabel('Frequency (Hz)');

% find top 3 maximum amplitude values and corresponding indeces
[amps, is] = maxk(1/length(x)*fftshift(abs(fft(x))),3);

% find maximum frequency
freqs = freq_domain(is);

% find acceleration offset
i_zero = find(abs(freqs) < 0.000001);
zero_amp = amps(i_zero);

% take only the positive max frequency
max_freq = freqs(freqs > 0); 

% find corresponding amp
max_i = find(freqs == max_freq);
max_amp = amps(max_i);

