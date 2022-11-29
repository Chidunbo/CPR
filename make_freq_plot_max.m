function [max_amp,max_freq]  = make_freq_plot_max(x, Fs)

% make a frequency domain plot with frequency labels
% and output the max amplitude and the corresponding dominant frequency(Hz)
%
%   x = input signal
%   Fs = sampling frequency in Hz

if(mod(length(x),2) ~=0)
    x = x(1:end-1);
end
% frequency domain
freq_domain = linspace(-Fs/2, Fs/2-Fs/length(x),length(x));

% plot signal over frequency domain
plot(freq_domain, 1/length(x)*fftshift(abs(fft(x))))

% find top 2 maximum amplitude value and corresponding index
[max_amp, max_i] = maxk(1/length(x)*fftshift(abs(fft(x))),5);

% find maximum frequency
max_freq = freq_domain(max_i);

% take only the positive max frequency
max_freq = max(max_freq(max_freq > 0)); 


ylabel('Magnitude of signal');
xlabel('Frequency (Hz)');